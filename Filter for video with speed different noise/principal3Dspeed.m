clear all
close all
clc


%eqm_disparity =  2467.5
%eqm_disparity_observation =  2468.3
%eqm_real =  19.925
%eqm_real_observation =  70.106


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
sigma_px = 10;
sigma_py = 10;
sigma_pz = 10;
sigma_pl_camera = 1000;
sigma_pv_camera = 1000;


F = [ 1 T_e 0   0 0 0  ;
      0 1   0 0   0 0  ;
      0 0   1 T_e 0 0  ;
      0 0   0 1   0 0  ;
      0 0   0 0   1 T_e;
      0 0   0 0   0 1  ];


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

   
% H alternatif
% H = [ 1 0 0 0 0 0;
%    0 0 1 0 0 0;
%    0 0 0 0 1 0];

MQ = [ (T_e^3)/3   (T_e^2)/2 0         0          0     0           ; 
      (T_e^2)/2   T_e       0         0           0     0           ;  
      0           0         (T_e^3)/3 (T_e^2)/2   0     0      ;
      0           0         (T_e^2)/2 T_e         0     0      ;
      0           0          0    0        (T_e^3)/3 (T_e^2)/2;
      0           0          0    0         (T_e^2)/2 T_e     ];

 
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

R_camera = [ sigma_pl_camera^2          0         ;
                     0          sigma_pv_camera^2];
     
% focale f
f_d = [8/(4.4e-3*1624/800); 8/(4.4e-3*1224/600)];
%f_d = [-8; -8];
% Baseline
b = 20;
% Number of particule
nofParticles = 100;
%   - dPP:        coordinates of the principal point
dPP = [0 0];
% Number of sampling for the gaussian at each iteration
n_particule = 100;

% We have to determine which unite are used for postions and speed (m, m/s
% ? cm, cm/s ? 
x_init_reel = [3 2 -4 4 5 6]';
%New init, why not start a 0...
%x_init = [0 2 0 2 0 0.5]';

% x_init alternatif 
% x_init = [3 -4 2 40 20 30] ;

%variance_initial = 20000;
variance_initial = [ 200 0 0 0 0 0;
    0 10   0 0 0 0;
    0 0   200 0 0 0;
    0 0   0 10 0 0;
    0 0 0 0 200 0;
    0 0 0 0 0 10];

distance_entre_camera = 10;
position_camera_1 = [0,0,0];
position_camera_2 = [distance_entre_camera,0,0];

vecteur_x_reel = creat_trajectoire_3D(F, Q, x_init_reel, T);

%vecteur_x_modify = vecteur_x([1 3 5],:);
%vecteur_x_modify(4,:) = ones(1,T);
vecteur_x_disparity = real_to_disparity_with_speed(vecteur_x_reel, f_d, b,dPP);

x_init_disparity = vecteur_x_disparity(:,1);


vecteur_y_disparity(1:3,:) = creat_observations_3D_camera(H,R_camera,vecteur_x_reel([1 3 5 7],:),T,f_d,b);
vecteur_y_disparity(4,:) = ones(1,T);
%vecteur_y_disparity = vecteur_x_disparity(1:3,:) %Try with real value

%R = 10*R
[x_kalm_real] = Kalman_New_Dimension(T_e,M,H,T,F,Q,R,x_init_reel,x_init_disparity,vecteur_x_reel,vecteur_y_disparity,variance_initial,n_particule,f_d, b,dPP);



[eq , eqm_real] = mean_erreur_quadratique_suj(vecteur_x_reel([1 3 5],:), x_kalm_real([1 3 5],:), T );
% The eqm is very high it should be a vecteur computing the error for each
% component of the vector or at least an eqm for the position vector and
% one for the speed vector
eqm_real
[eq , eqm_real_observation] = mean_erreur_quadratique_suj(vecteur_x_reel([1 3 5],:), disparity_to_real(vecteur_y_disparity, f_d, b,dPP)(1:3,:), T );
eqm_real_observation
