clear all
close all
clc

T_e = 1;
T = 100; %Number of observations
sigma_Q = 1;
sigma_px = 200;
sigma_py = 200;

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


vecteur_x = creat_trajectoire(F, Q, x_init, T);
vecteur_y = creat_observations(H,R,vecteur_x,T);


%load('vecteur_x_avion_voltige.mat');
%load('vecteur_y_avion_voltige.mat');

%  x_voltige =load('vecteur_x_avion_voltige.mat');
%  y_voltige =load('vecteur_y_avion_voltige.mat');

M = 10;
weight = ones(1,M)/M;
weight_init = weight;
x_kalm = zeros(length(x_init),M,T);
%x_kalm(:,1,1) = [-1000 0 600 0]';x_kalm(:,2,1) = [3000 0 -600 0]';x_kalm(:,3,1) = [3000 0 4000 0]';
%x_kalm([1,3],:,1) = unifrnd(0,4000,2,M);
U = randn(2,M) * sqrtm(eye(M))*200 + repmat(vecteur_y(:,1),1,M); % C'est quoi ? et puis sqrtm(Eyes) = Eyse non ? c'est pas sqrt(200) ?
%vecteur_x(:,i+1) = F * vecteur_x(:,i) + U;
x_kalm([1,3],:,1) = U;
P_kalm = ones(length(x_init),length(x_init),M);
%P_kalm(:,:,1) = eye(4,4); P_kalm(:,:,2) = eye(4,4);P_kalm(:,:,3) = eye(4,4);

x_kalm_mean = ones(length(x_init),T);
x_kalm_mean(:,1) = weight*x_kalm(:,:,1)';

for k=1:T-1
  y_k=vecteur_y(:,k+1);
  [x_kalm(:,:,k+1) P_kalm weight] = filtre_de_kalman( F, Q, H, R, y_k,x_kalm(:,:,k), P_kalm,M,weight);
  x_kalm_mean(:,k+1) = weight*x_kalm(:,:,k+1)';
end

% Estimation avion de ligne


[eq , eqm] = mean_erreur_quadratique_suj(vecteur_x, x_kalm_mean, T );
eqm

%eqm

% abscisses en fonction du temps
%figure(1)
%plot(vecteur_x(1,:),'b')
%hold on
%plot(vecteur_y(1,:),'g')
%hold on
%plot(x_est(1,:),'r')

% ordonnées en fonction du temps
%figure(2)
%plot(vecteur_x(3,:),'b')
%hold on
%plot(vecteur_y(2,:),'g')
%hold on
%plot(x_est(3,:),'r')

% Print
%vecteur_x
%vecteur_y
%x_est
% Trajectoires 
figure(4)
plot(vecteur_x(1,:), vecteur_x(3,:),'b')
hold on
plot(vecteur_y(1,:), vecteur_y(2,:),'g')
hold on
plot(x_kalm_mean(1,:), x_kalm_mean(3,:),'*')
hold on
for i=1:M
plot(reshape (x_kalm(1,i,:), T, 1), reshape (x_kalm(3,i,:), T, 1),'r')
end