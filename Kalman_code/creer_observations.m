function [ vecteur_y ] = creer_observations( H,R,vecteur_x,T)

rand = randn(2,T);
V = zeros(2,T);
vecteur_y = zeros(2,T);

racine_R = sqrtm(R);

for i=1:T
    V(:,i) = racine_R*rand(:,i);
end

for k=1:T
    vecteur_y(:,k) = H*vecteur_x(:,k) + V(:,k);
end

end