%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonction fais la projection d'un objet dans R3 sur un plan (R2) (projection
% objet sur une image)
% On suppose les coordonnees homogenes 
% input : 
% - f : focale de la lentille
% - X_real_word : coordonnees de l'image en 3D (vecteur 4*1)
% 
% output :
% - X_image : projété de x (3*1)
% cours : https://team.inria.fr/steep/files/2015/03/poly_3D.pdf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X] = real_to_left_camera(X_real_world,f_d,b)

K = [f_d(1) 0 0;
     0 f_d(2) 0;
     0 0 1];

t = zeros(3,1);
P = [K, t];

X = P*X_real_world;
%X_Image = X(1:2,:)./X(3,:);

end