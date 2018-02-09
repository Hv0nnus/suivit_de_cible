function vecteur_y = creat_observations(H,R,vecteur_x,T,lambda,pd)

vecteur_y = cell(T,1);

for k=1:T # Iteration temporelle

  taille = size(vecteur_x{k})(2); # nombre d'observation
  a = [];
  non_detecter = 0;
  for i=1:taille
    di = rand() < pd;
    if (di || (i==taille &&  (non_detecter + 1) == taille ))
      V = sqrtm(R) * randn(2,1);
      a = [a,H*vecteur_x{k}(:,i) + V];
    else
      non_detecter = non_detecter + 1;
    end
  end
  n_false_alarm = poissrnd(lambda);
  for j=1:n_false_alarm
    a = [a,rand(2,1)*1000];
  end
  vecteur_y{k} = a;
end

