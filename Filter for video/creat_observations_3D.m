function vecteur_y = creat_observations_D(H,R,vecteur_x,T)

V = sqrtm(R) * randn(3,T);

vecteur_y=H*vecteur_x + V;

end