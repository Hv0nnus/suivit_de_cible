function vecteur_y = creer_observation(vecteur_x,R,T)

V = sqrt(R) * randn(1,T);
vecteur_y= (vecteur_x.^2)/20 + V;

end

