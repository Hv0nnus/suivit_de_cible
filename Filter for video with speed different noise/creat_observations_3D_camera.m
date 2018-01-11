function [vecteur_y] = creat_observations_3D_camera(H,R,vecteur_x,T,f_d,b)

  vecteur_x_right = real_to_right_camera(vecteur_x,f_d,b);
  vecteur_x_left = real_to_left_camera(vecteur_x,f_d,b);
vecteur_x_left(:,1:10)
  vecteur_x_right(1:2,:) = vecteur_x_right(1:2,:) + sqrtm(R) * randn(2,T);
  vecteur_x_left(1:2,:) = vecteur_x_left(1:2,:) + sqrtm(R) * randn(2,T);
vecteur_x_left(:,1:10)
  
  vecteur_y = [1 0 0 ; 0 1 0 ; -1 0 0 ; 0 0 1] * vecteur_x_left + [0 0 0 ; 0 0 0 ; 1 0 0 ; 0 0 0] * vecteur_x_right;
  vecteur_y = vecteur_y(1:3,:)./vecteur_y(4,:);

  
end