function vecteur_y = creat_observations_3D(H,R,vecteur_x,T)

V = sqrtm(R) * randn(3,T);

vecteur_y=vecteur_x + V;

end