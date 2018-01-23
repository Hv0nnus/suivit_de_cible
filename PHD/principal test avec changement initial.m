clear all
close all
clc

T_e = 1;
T = 100; %Number of observations
sigma_Q = 1;
sigma_px = 10;
sigma_py = 10;

F = [ 1 T_e 0 0;
      0 1   0 0;
      0 0   1 T_e;
      0 0   0 1];
 H = [ 1 0 0 0;
     0 0 1 0];
 
 MQ = [ (T_e^3)/3   (T_e^2)/2 0         0; 
        (T_e^2)/2   T_e       0         0; 
        0           0         (T_e^3)/3 (T_e^2)/2;
        0           0         (T_e^2)/2 T_e];
 
 Q = (sigma_Q^2) * MQ;
 
 R = [ sigma_px^2 0;
       0          sigma_py^2 ]; 
 
 x_init = [3 40 -4 20]';
 x_init = [0 0 0 0]';
 
 x_kalm = x_init;
 P_kalm = eye(4,4);
 
 
for i=1:10
  vecteur_x = creat_trajectoire(F, Q, x_init, T);
  %vecteur_y = creat_observations(H,R,vecteur_x,T);
  %vecteur_x
  % Trajectoires
  figure(4)
  plot(vecteur_x(1,:), vecteur_x(3,:),'b')
  hold on
end


