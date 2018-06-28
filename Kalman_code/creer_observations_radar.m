function [ vecteur_y ] = creer_observations_radar(R,vecteur_x,T)

rand = randn(2,T);
V = zeros(2,T);
f_x=transpose([0:100]);
g_x=transpose([0:100]);
for j=1:T
    f_x(j)=sqrt(vecteur_x(1,j)^2+vecteur_x(3,j)^2);
    g_x(j)=atan(vecteur_x(3,j)/(vecteur_x(1,j)));
end


vecteur_y = zeros(2,T);
racine_R = sqrtm(R);
    
for i=1:T
    V(:,i) = racine_R*rand(:,i);
end

for k=1:T
    vecteur_y(:,k) = [g_x(k);f_x(k)] + V(:,k);
end

end

