function [ vecteur_x ] = creer_trajectoire( F,Q,x_init,T )
rand = randn(4,T);
U = zeros(4,T);
vecteur_x = zeros(4,T);

x_init
vecteur_x(:,1)

vecteur_x(:,1) = x_init;

racine_Q = sqrtm(Q);

for i=1:T
    U(:,i) = racine_Q*rand(:,i);
end

for k=2:T
    vecteur_x(:,k) = F*vecteur_x(:,k-1) + U(:,k);
end

end

