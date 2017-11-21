%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Projection to the disparity space
%
%
%
%
%
%


function [ Y_disp ] = real_to_disparity(X_real_world, f, b)

K = [f 0 0;
     0 f 0;
     0 0 1];
% Matrice de projection sur la camera gauche
P_l = [K, [0,0,0]'];

t = [f*b,0,0];
% Matrice de projection sur la camera droite
P_r = [K, t'];

% Matrice de projection sur l'espace de disparité 
P_d = [ P_l(1,:);
        P_l(2,:);
        P_r(1,:) - P_l(1,:);
        P_l(3,:)];

Y_disp = P_d*X_real_world;
Y_disp = Y_disp./Y_disp(4,:);    


end