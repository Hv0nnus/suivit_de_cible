% This function will apply Kalman filter in 3D space
% vecteur_x should not be here but we will use it to plot
function [x_kalm_real] = Kalman_New_Dimension(M,H,T,F,Q,R,vecteur_x_real,vecteur_y_disparity,variance_initial,n_particule,f_d, b,dPP)
  
  n = 3;% length(x_init); % Dimension of the disparity space

  %weight = ones(1,M)/M; % weight of the Gaussians
  particule_disparity = ones(n+1,n_particule,T); %We will store the value of particule in disparity space here
  particule_real = ones(n+1,n_particule,T); %We will store the value of particule in disparity space here

  U = (randn(n_particule,3) * sqrtm(eye(3)*variance_initial))' + repmat(vecteur_y_disparity(1:3,1),1,n_particule); % start of different particule
  particule_disparity(1:3,:,1) = U;
  particule_disparity_save = ones(3,n_particule,T);
  particule_disparity_save(1:3,:,1) = particule_disparity(1:3,:,1);

  x_kalm_real(:,1) = disparity_to_real(vecteur_y_disparity(1:4,1), f_d, b,dPP);
  
  x_kalm_disparity = ones(4,T);
  x_kalm_disparity(:,1) = vecteur_y_disparity(1:4,1);

  for k=1:T-1
    %particule_disparity(:,:,k)
    particule_real(:,:,k) = disparity_to_real(particule_disparity(:,:,k), f_d, b,dPP);
    %particule_real(:,:,k+1) = Markov_Kernel(F,Q,particule_real(:,:,k),n_particule);
    %particule_disparity(:,:,k+1) = real_to_disparity(particule_real(:,:,k+1), f_d, b,dPP);
    %essaie...
    particule_disparity(:,:,k+1) = Markov_Kernel(F,Q,particule_disparity(:,:,k),n_particule);

    particule_disparity_save(:,:,k+1) = particule_disparity(1:3,:,k+1);
    [x_kalm_disparity(1:3,k+1) P_kalm_disparity ]= recover_gaussian(particule_disparity(1:3,:,k+1));
    %x_kalm_disparity(1:3,k+1)
    [x_kalm_disparity(1:3,k+1) P_kalm_disparity ] = filtre_de_kalman_update(H, R, vecteur_y_disparity(1:3,k+1),x_kalm_disparity(1:3,k+1), P_kalm_disparity);
    %x_kalm_disparity(1:3,k+1)
    
    x_kalm_real(:,k+1) = disparity_to_real(x_kalm_disparity(1:4,k+1), f_d, b,dPP);
    particule_disparity(1:3,:,k+1) = (randn(n_particule,3) * sqrtm(P_kalm_disparity))' + repmat(x_kalm_disparity(1:3,k+1),1,n_particule);
    %x_kalm_disparity(:,k)
    mean(mean(P_kalm_disparity))/9;
  end
  %x_kalm_disparity
  %plot
  vecteur_y_real = disparity_to_real(vecteur_y_disparity, f_d, b,dPP);
  figure(1)
  axis([-1000 1000 -1000 1000 -1000 1000])
  plot3(vecteur_x_real(1,:), vecteur_x_real(2,:), vecteur_x_real(3,:),'b')
  hold on
  plot3(vecteur_y_real(1,:),vecteur_y_real(2,:),vecteur_y_real(3,:),'g')
  hold on
  plot3(x_kalm_real(1,:),x_kalm_real(2,:),x_kalm_real(3,:),'r')
  hold on
  for k=1:T
    %plot3(particule_real(1,:,k), particule_real(2,:,k), particule_real(3,:,k),'r+');
    hold on
  end
  ax = 1000
  axis([-ax ax -ax ax -ax ax])
  hold off
  
  vecteur_x_disparity = real_to_disparity(vecteur_x_real, f_d, b,dPP);
  figure(2)
  plot3(vecteur_x_disparity(1,:), vecteur_x_disparity(2,:), vecteur_x_disparity(3,:),'b')
  hold on
  plot3(vecteur_y_disparity(1,:),vecteur_y_disparity(2,:),vecteur_y_disparity(3,:),'g')
  hold on
  plot3(x_kalm_disparity(1,:),x_kalm_disparity(2,:),x_kalm_disparity(3,:),'r')
  hold on
  
  for k=1:T
    %plot3(particule_disparity_save(1,:,k),particule_disparity_save(2,:,k),particule_disparity_save(3,:,k),'b+')
    hold on
    %plot3(particule_disparity(1,:,k), particule_disparity(2,:,k), particule_disparity(3,:,k),'r+');
    hold on
  end
[eq , eqm_disparity] = mean_erreur_quadratique_suj(vecteur_x_disparity, x_kalm_disparity, T );
eqm_disparity
[eq , eqm_disparity_observation] = mean_erreur_quadratique_suj(vecteur_x_disparity, vecteur_y_disparity, T );
eqm_disparity_observation
end