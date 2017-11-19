clear all
close all
clc

pkg load statistics
%pkg load geom3d

M = 10; % Number of Gaussians that we use
T_e = 1;
T = 100; %Number of observations
sigma_Q = 100;
sigma_px = sigma_Q*50;
sigma_py = sigma_Q*50;
sigma_pz = sigma_Q*50;

F = [ 1 T_e 0 0 0 0;
    0 1   0 0 0 0;
    0 0   1 T_e 0 0;
    0 0   0 1 0 0;
    0 0 0 0 1 T_e;
    0 0 0 0 0 1];
H = [ 1 0 0 0 0 0;
   0 0 1 0 0 0;
   0 0 0 0 1 0];

MQ = [ (T_e^3)/3   (T_e^2)/2 0         0          0     0           ; 
      (T_e^2)/2   T_e       0         0           0     0           ;  
      0           0         (T_e^3)/3 (T_e^2)/2   0     0      ;
      0           0         (T_e^2)/2 T_e         0     0      ;
      0           0          0    0        (T_e^3)/3 (T_e^2)/2;
      0           0          0    0         (T_e^2)/2 T_e     ];

Q = (sigma_Q^2) * MQ;

R = [ sigma_px^2 0          0;
     0           sigma_py^2 0;
     0           0          sigma_pz^2]; 

x_init = [3 40 -4 20 2 30]';

variance_initial = 2000;

distance_entre_camera = 10;
position_camera_1 = [0,0,0];
position_camera_2 = [distance_entre_camera,0,0];

vecteur_x = creat_trajectoire_3D(F, Q, x_init, T);
%TODO change vecteur_y, because is should not be that, we have to pass by the camera.
%[vecteur_y] = projection_to_new_dimension(cl_observation, cr_observation)
vecteur_y = creat_observations_3D(H,R,vecteur_x,T);

[x_kalm_mean,x_kalm] = Kalman_New_Dimension(M,H,T,F,MQ,Q,R,x_init,vecteur_y,variance_initial);

% 

[eq , eqm] = mean_erreur_quadratique_suj(vecteur_x, x_kalm_mean, T );
eqm

%eqm

% Trajectoires 
figure(4)
plot3(vecteur_x(1,:), vecteur_x(3,:), vecteur_x(5,:),'b')
hold on
plot3(vecteur_y(1,:), vecteur_y(2,:), vecteur_y(3,:),'g')
hold on
plot3(x_kalm_mean(1,:), x_kalm_mean(3,:),x_kalm_mean(5,:),'*')
hold on
for i=1:M
  plot3(reshape (x_kalm(1,i,:), T, 1), reshape (x_kalm(3,i,:), T, 1),reshape (x_kalm(5,i,:), T, 1),'r')
end