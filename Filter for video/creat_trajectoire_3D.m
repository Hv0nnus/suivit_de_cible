function vecteur_x = creat_trajectoire_3D(F, Q, x_init, T)

  vecteur_x = zeros(6,T);
  vecteur_x(:,1) = x_init;

  for i=1:T-1
    U = sqrtm(Q) * randn(6,1);
    vecteur_x(:,i+1) = F * vecteur_x(:,i) + U;      
  end



end

