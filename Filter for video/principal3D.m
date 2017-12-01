clear all
close all
clc
% {name] alternatif : convert vector x from [ x, vx, y, vy ,z, vz] to [x,
% y,z, vx, vy, vz]

pkg load statistics
%pkg load geom3d

% Parameters of the cameras set up
% f =
% b =
%fréquence d'aquisition  (Img/Sec)
fps = 1;

% Tps temps d'enregistrement en seconde
Tps = 100;


M = 1; % Number of gaussian that we use
T_e = 1/fps;
T = fps*Tps; %Number of observations 
sigma_Q = 1;
sigma_px = 50;
sigma_py = 50;
sigma_pz = 50;

F_generate_trajectory = [ 1 T_e 0 0 0 0;
    0 1   0 0 0 0;
    0 0   1 T_e 0 0;
    0 0   0 1 0 0;
    0 0 0 0 1 T_e;
    0 0 0 0 0 1];

% F in 3D
F = eye(3);

% F alternatif
% F = [ 1 0 0 T_e 0 0;
%     0 1 0 0 T_e 0;
%     0 0 1 0 0 T_e;
%     0 0 0 1 0 0;
%     0 0 0 0 1 0;
%     0 0 0 0 0 1];


H = [ 1 0 0 0 0 0;
   0 0 1 0 0 0;
   0 0 0 0 1 0];

%3D
H = eye(3);
   
% H alternatif
% H = [ 1 0 0 0 0 0;
%    0 0 1 0 0 0;
%    0 0 0 0 1 0];

MQ__generate_trajectory = [ (T_e^3)/3   (T_e^2)/2 0         0          0     0           ; 
      (T_e^2)/2   T_e       0         0           0     0           ;  
      0           0         (T_e^3)/3 (T_e^2)/2   0     0      ;
      0           0         (T_e^2)/2 T_e         0     0      ;
      0           0          0    0        (T_e^3)/3 (T_e^2)/2;
      0           0          0    0         (T_e^2)/2 T_e     ];
%dimension 3 for MQ
MQ = [ (T_e^3)/3    0         0; 
       0           (T_e^3)/3    0; 
       0              0      (T_e^3)/3];
 
%  MQ alternatif 
%  MQ = [ (T_e^3)/3    0         0     (T_e^2)/2     0          0            ; 
%       0           (T_e^3)/3    0         0     (T_e^2)/2      0            ; 
%       0              0      (T_e^3)/3    0         0         (T_e^2)/2     ; 
%    (T_e^2)/2         0         0         T_e       0          0            ;
%       0          (T_e^2)/2     0         0        T_e         0            ;
%       0              0      (T_e^2)/2    0         0         T_e         ] ;

Q = (sigma_Q^2) * MQ;

R = [ sigma_px^2 0          0;
     0           sigma_py^2 0;
     0           0          sigma_pz^2]; 
    
% focale f
f_d = [8/(4.4e-3*1624/800); 8/(4.4e-3*1224/600)];
%f_d = [-8; -8];
% Baseline
b = 20;
% Number of particule
nofParticles = 250;
%   - dPP:        coordinates of the principal point
dPP = [0 0];
% Number of sampling for the gaussian at each iteration
n_particule = 100;

% We have to determine which unite are used for postions and speed (m, m/s
% ? cm, cm/s ? 
x_init = [3 2 -4 4 5 6]';
%New init, why not start a 0...
%x_init = [0 2 0 2 0 0.5]';

% x_init alternatif 
% x_init = [3 -4 2 40 20 30] ;


variance_initial = 2000;

distance_entre_camera = 10;
position_camera_1 = [0,0,0];
position_camera_2 = [distance_entre_camera,0,0];

vecteur_x = creat_trajectoire_3D(F_generate_trajectory, MQ__generate_trajectory, x_init, T);

vecteur_x_modify = vecteur_x([1 3 5],:);
vecteur_x_modify(4,:) = ones(1,T);
vecteur_x_disparity = real_to_disparity(vecteur_x_modify, f_d, b,dPP);

%vecteur_x_disparity = vecteur_x_disparity(1:3,:)/vecteur_x_disparity(4,:);

vecteur_y_disparity(1:3,:) = creat_observations_3D(H,R,vecteur_x_disparity(1:3,:),T);
vecteur_y_disparity(4,:) = ones(1,T);
%vecteur_y_disparity = vecteur_x_disparity(1:3,:) %Try with real value


[x_kalm_real] = Kalman_New_Dimension(M,H,T,F,MQ,Q,R,vecteur_x_modify,vecteur_y_disparity,variance_initial,n_particule,f_d, b,dPP);



[eq , eqm] = mean_erreur_quadratique_suj(vecteur_x([1 3 5],:), x_kalm_real(1:3,:), T );
% The eqm is very high it should be a vecteur computing the error for each
% component of the vector or at least an eqm for the position vector and
% one for the speed vector
eqm

%eqm

% Trajectoires dans disparity
%figure(3)
%plot3(vecteur_x_disparity(1,:), vecteur_x_disparity(2,:), vecteur_x_disparity(3,:),'b')
hold on
%plot3(vecteur_y_disparity(1,:), vecteur_y_disparity(2,:), vecteur_y_disparity(3,:),'g')
hold on
%plot3(x_kalm_mean(1,:), x_kalm_mean(3,:),x_kalm_mean(5,:),'*')
hold on
for i=1:M
  %plot3(reshape (x_kalm(1,i,:), T, 1), reshape (x_kalm(3,i,:), T, 1),reshape (x_kalm(5,i,:), T, 1),'r')
end

% Trajectoires dans real
%figure(4)
%plot3(vecteur_x(1,:), vecteur_x(3,:), vecteur_x(5,:),'b')
hold on
%plot3(x_kalm_real(1,:), x_kalm_real(2,:), x_kalm_real(3,:),'r')
hold on
%plot3(x_kalm_mean_real(1,:), x_kalm_mean_real(2,:),x_kalm_mean_real(3,:),'*')
hold on
for i=1:M
  %plot3(reshape (x_kalm(1,i,:), T, 1), reshape (x_kalm(3,i,:), T, 1),reshape (x_kalm(5,i,:), T, 1),'r')
end