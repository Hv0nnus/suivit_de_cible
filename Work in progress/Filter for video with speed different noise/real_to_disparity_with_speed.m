%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Projection to the disparity space
%
%
%
%
%
%


function [ X_disp ] = real_to_disparity_with_speed(X_real_world, f_d, b,dPP)

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


X_disp = ones(7,size(X_real_world)(2));
X_disp([1 3 5 7],:) = P_d*X_real_world([1 3 5 7],:);
X_disp([1 3 5 7],:) = X_disp([1 3 5 7],:)./X_disp(7,:);  

for k=1:size(X_real_world)(2)
  X_disp(2,k) = (1/(X_real_world(5,k))**2)*f_d(1)*(X_real_world(2,k)*X_real_world(5,k) - X_real_world(6,k)*X_real_world(1,k));
  X_disp(4,k) = (1/(X_real_world(5,k))**2)*f_d(2)*(X_real_world(4,k)*X_real_world(5,k) - X_real_world(6,k)*X_real_world(3,k));
  X_disp(6,k) = (1/(X_real_world(5,k))**2)*(-f_d(1))*b*X_real_world(6,k);
end


end