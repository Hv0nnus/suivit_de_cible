clear all
close all
clc

pkg load statistics

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

x_init = []';

ps = 0.01; # disparition une fois qu'il est né 
beta = 0.0001; # Naissance
lambda = 0.01; # nombre de false alarm
pd = 0.9; # est ce qu'on voit bien le truc a bon endroit

[vecteur_x, nombre_cible] = creat_trajectoire(F, Q, x_init, T,beta,ps);

vecteur_y = creat_observations(H,R,vecteur_x,T,lambda,pd);



#M_max = 1000 ;#nombre_gaussien max
n_k = 4; #Nombre de Gaussien initial
nombre_gaussien_a_garder = n_k
weight = cell(T,1);
weight{1} = ones(1,n_k)/n_k;

x_kalm = cell(T,1);
x_kalm{1} = zeros(length(x_init),n_k);


U = randn(2,n_k) * sqrtm(eye(n_k))*1 + repmat(vecteur_y{1},1,n_k);
x_kalm = cell(T,1);
x_kalm{1}([1,3],1:n_k) = U;
x_kalm{1}([2,4],1:n_k) = repmat([4,3]',1,n_k);
P_kalm = cell(T,1);
for i=1:n_k
  P_kalm{1}(:,:,i) = eye(4,4);
end

for k=1:T-1
  [x_kalm{k+1} P_kalm{k+1} weight{k+1}, n_k] = filtre_de_kalman( F, Q, H, R, vecteur_y{k+1},x_kalm{k}, P_kalm{k},n_k,weight{k},ps,pd,lambda,nombre_gaussien_a_garder);
end


% Estimation avion de ligne
%[eq , eqm] = mean_erreur_quadratique_suj(vecteur_x, x_kalm_mean, T );
%eqm

%eqm


%plot(vecteur_x{1}(1,1), vecteur_x{1}(3,1));
%axis([0 1000 0 1000]);
%vh = get(gca,'children');
%for t=1:T
%  for k=1:size(vecteur_x{t}(1,:))
%    set(vh, 'xdata',vecteur_x{t}(1,k), 'ydata', vecteur_x{t}(3,k));
%    hold on
%    pause(0.1);
%  end
%end
figure(2)
for t=1:T
  plot(vecteur_x{t}(1,:), vecteur_x{t}(3,:),'b+')

  plot(vecteur_y{t}(1,:), vecteur_y{t}(2,:),'g+')   
  hold on
  plot(x_kalm{t}(1,:), x_kalm{t}(3,:) ,'r+')
  hold on
  drawnow;
  hold on
  pause(0.1);
end