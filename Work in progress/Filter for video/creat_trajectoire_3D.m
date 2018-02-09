function vecteur_x = creat_trajectoire_3D(F_generate_trajectory, MQ__generate_trajectory, x_init, T)

  vecteur_x = zeros(6,T);
  vecteur_x(:,1) = x_init;

  for i=1:T-1
    U = sqrtm(MQ__generate_trajectory) * randn(6,1);
    vecteur_x(:,i+1) = F_generate_trajectory * vecteur_x(:,i) + U;      
  end



end

