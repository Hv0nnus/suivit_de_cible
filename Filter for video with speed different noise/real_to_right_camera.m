%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonction fais la projection d'un objet dans R3 sur un plan (R2) (projection
% objet sur une image)
% On suppose les coordonnees homogenes 
% La paire de camera est consideree comme horizontalement rectifié
% input : 
% - f : focale de la lentille
% - X_real_word : coordonnees de l'image en 3D (vecteur 4*1)
% - b : the baseline (cf article)
% output :
% - X_image : projété de x (3*1)
% cours : https://team.inria.fr/steep/files/2015/03/poly_3D.pdf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X] = real_to_right_camera(X_real_world,f_d,b)

K = [f_d(1) 0 0;
     0 f_d(2) 0;
     0 0 1];
t = [b*f_d(1),0,0];
P = [K, t'];

X = P*X_real_world;

end