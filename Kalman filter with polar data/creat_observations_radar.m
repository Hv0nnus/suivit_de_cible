function vecteur_y = creer_observations_radar(R,vecteur_x,T)

V = sqrtm(R) * randn(2,T);

x=vecteur_x(1,:);
y=vecteur_x(3,:);
angle = atan2(y,x) ;
distance = sqrt(x.^2 + y.^2);
vecteur_y = [angle; distance] + V;


end



