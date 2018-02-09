%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Projection to the disparity space
%
%
%
%
%
%


function [ X_disp ] = real_to_disparity(X_real_world, f_d, b,dPP)

K = [f_d(1) 0 dPP(1);
     0 f_d(2) dPP(2);
     0 0 1];
% Matrice de projection sur la camera gauche
P_l = [K, [0,0,0]'];

t = [f_d(1)*b,0,0];
% Matrice de projection sur la camera droite
P_r = [K, t'];

% Matrice de projection sur l'espace de disparité 
P_d = [ P_l(1,:);
        P_l(2,:);
        P_r(1,:) - P_l(1,:);
        P_l(3,:)];


X_disp = P_d*X_real_world;
X_disp(:,1:10);
X_disp = X_disp./X_disp(4,:);  


end