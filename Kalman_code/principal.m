clear all
close all
clc

T_e = 1;
T = 100;
sigma_Q = 5 ;
sigma_px = 50 ;
sigma_py = 50 ;

F = [1,T_e,0,0;0,1,0,0;0,0,1,T_e;0,0,0,1];
Q = sigma_Q * [(T_e^3)/3,(T_e^2)/2,0,0;(T_e^2)/2,T_e,0,0;0,0,(T_e^3)/3,(T_e^2)/2;0,0,(T_e^2)/2,T_e];
H = [1,0,0,0;0,0,1,0];
R = [sigma_px^2,0;0,sigma_py^2];

x_init = [3;40;-4;20];

x_kalm = x_init ;

P_kalm = eye(4);


vecteur_x = creer_trajectoire(F,Q,x_init,T);

vecteur_y = creer_observations(H,R,vecteur_x,T);

err_quadra(1) = 0;
%err_quadra_bruite(1) = 0;

for k=2:T
     y_k = vecteur_y(:,k);
     [ x_kalm(:,k),P_kalm ] = filtre_de_kalman( F,Q,H,R,y_k,x_kalm(:,k-1),P_kalm);
     err_quadra(k) = transpose(vecteur_x(:,k) - x_kalm(:,k))*(vecteur_x(:,k) - x_kalm(:,k));
     %err_quadra_bruite(k) = transpose(vecteur_x(:,k) -x_kalm(:,k))*(vecteur_x(:,k) - x_kalm(:,k));
end

erreur_moyenne = mean(sqrt(err_quadra))
%err_quadra_bruite(sqrt(err_quadra


f1 = figure(1)
%axis([-1000 1000 -1000 1000 -1000 1000])
for t=1:T
plot(vecteur_x(1,1:t), vecteur_x(3,1:t),'b')
hold on
plot(vecteur_y(1,1:t), vecteur_y(2,1:t),'g')
hold on
plot(x_kalm(1,1:t), x_kalm(3,1:t),'r')
hold on
drawnow;
%print(f1,strcat("Kalman.png"))
pause(0.01);
end

