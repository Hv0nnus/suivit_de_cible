clear all
close all
clc

T_e = 1;
T = 100;
sigma_Q = 10;
sigma_angle = 1*pi/180;
sigma_dist = 1*10;

F = [ 1 T_e 0 0;
    0 1 0 0;
    0 0 1 T_e;
    0 0 0 1];
 H = [ 1 0 0 0;
     0 0 1 0];
 
 MQ = [ (T_e^3)/3 (T_e^2)/2 0 0; 
     (T_e^2)/2 T_e 0 0; 
     0 0 (T_e^3)/3 (T_e^2)/2;
     0 0 (T_e^2)/2 T_e];
 
 Q = (sigma_Q^2) * MQ;
 
 R = [ sigma_angle^2 0;
     0 sigma_dist^2 ]; 
 
 x_init = [3 40 -4 20]';
 x_kalm = x_init;
 P_kalm = eye(4,4);
 
 
  
vecteur_x = creat_trajectoire(F, Q, x_init, T);
vecteur_y = creat_observations_radar(R,vecteur_x,T);

 
%load('vecteur_x_avion_voltige.mat');
%load('vecteur_y_avion_voltige.mat');

%x_voltige =load('vecteur_x_avion_voltige.mat');
%y_voltige =load('vecteur_y_avion_voltige.mat');

% vecteur_x(1:4,1:10)
% vecteur_y(1:2,1:10)


r = vecteur_y(2,:);
theta = vecteur_y(1,:);
vecteur_y_cart = [ r.*cos(theta); r.*sin(theta) ];
 
 x_est=zeros(size(vecteur_x));
 x_est(:,1)=x_kalm;
 P_0 = P_kalm;
 for k=1:T-1
     y_k=vecteur_y(:,k+1);
     [x_est(:,k+1) P_0]=filtre_de_kalman_radar( F, Q, R, y_k,x_est(:,k), P_0);
 end
 
% Estimation avion de ligne

 
[eq , eqm] = mean_erreur_quadratique_suj(vecteur_x, x_est, T );

eqm

% abscisses en fonction du temps
% figure(1)
% plot(vecteur_x(1,:),'b')
% hold on
% plot(vecteur_y_cart(1,:),'g')
% hold on
% plot(x_est(1,:),'r')

% ordonnées en fonction du temps
% figure(2)
% plot(vecteur_x(3,:),'b')
% hold on
% plot(vecteur_y_cart(2,:),'g')
% hold on
% plot(x_est(3,:),'r')

% Trajectoires 
figure()
plot(vecteur_x(1,:), vecteur_x(3,:),'b')
hold on
plot(vecteur_y_cart(1,:), vecteur_y_cart(2,:),'g')
hold on 
plot(x_est(1,:), x_est(3,:),'r')