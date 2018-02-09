function vecteur_x = creer_trajectoire(F, Q, x_init, T)

  vecteur_x = zeros(4,T);
  vecteur_x(:,1) = x_init;

  for i=1:T-1
    U = sqrtm(Q) * randn(4,1);
    vecteur_x(:,i+1) = F * vecteur_x(:,i) + U;      
  end



end

