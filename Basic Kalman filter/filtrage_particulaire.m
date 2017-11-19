
% x = vecteur (correspond à x_(k-1) pour i = 1 à N
% yk = la dernière observation en mémoire
function  [ particule, poids_norm, estimateur ] = filtrage_particulaire(x,y,w,Q,R,H,k)

N = length(x);

%xn = randn(1,N)*sqrt(Q) + transition(x,k);

U = sqrtm(Q) * randn(4,1);
xn = F*x + U;

for i=2:N
    U = sqrtm(Q) * randn(4,1);
    xn(:,:,i) = F*x(:,:,i) + U;
end 


particule = xn;

yk = y(:,k);
Y = repmat(yk, 1,N);

poids =  w.*normpdf(Y,H*xn(:,:,k), R);
poids_norm = poids./(sum(poids));

estimateur = sum(poids_norm.*particule);

[particule, poids_norm] = reechantillonage(particule, poids_norm);

end