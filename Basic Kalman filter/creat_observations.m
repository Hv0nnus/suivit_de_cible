function vecteur_y = creer_observations(H,R,vecteur_x,T)

V = sqrtm(R) * randn(2,T);

vecteur_y=H*vecteur_x + V;

end

