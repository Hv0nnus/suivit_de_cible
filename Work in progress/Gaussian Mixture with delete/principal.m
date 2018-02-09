clear all
close all
clc

pkg load statistics

threshold = 3

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

M = 15;
weight = ones(1,M)/M;
weight_init = weight;
x_kalm = zeros(length(x_init),M);

U = randn(2,M) * sqrtm(eye(M))*200 + repmat(vecteur_y(:,1),1,M);

x_kalm([1,3],:) = U;
P_kalm = ones(length(x_init),length(x_init),M);

x_kalm_mean = ones(length(x_init),T);
x_kalm_mean(:,1) = weight*x_kalm';

x_kalm_plot{1} = x_kalm([1,3],:);

for k=1:T-1
  y_k=vecteur_y(:,k+1);
  [x_kalm P_kalm weight] = filtre_de_kalman( F, Q, H, R, y_k,x_kalm, P_kalm,M,weight,threshold);
  x_kalm_mean(:,k+1) = weight*x_kalm';
  M = length(weight);
  x_kalm_plot{k+1} = x_kalm([1,3],:);
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
plot(x_kalm_mean(1,:), x_kalm_mean(3,:),'r')
hold on
for k=1:T
   plot(x_kalm_plot{k}(1,:),x_kalm_plot{k}(2,:),'.r',"markersize",5)
end