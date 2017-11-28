% This function will apply Kalman filter in 3D space
% vecteur_x should not be here but we will use it to plot
function [x_kalm_mean,x_kalm] = Kalman_New_Dimension(M,H,T,F,MQ,Q,R,vecteur_x_real,vecteur_y_disparity,variance_initial,n_particule,f_d, b,dPP)
  
  n = 3;% length(x_init); % Dimension of the disparity space

  %weight = ones(1,M)/M; % weight of the Gaussians
  particule_disparity = ones(n+1,n_particule,T); %We will store the value of particule in disparity space here
  particule_real = ones(n+1,n_particule,T); %We will store the value of particule in disparity space here

  U = randn(3,n_particule) * sqrtm(eye(n_particule)*variance_initial) + repmat(vecteur_y_disparity(:,1),1,n_particule); % start of different particule
  particule_disparity(1:3,:,1) = U; % put of start value to the vector that will store the position
  particule_real(:,:,1) = disparity_to_real(particule_disparity(:,:,1), f_d, b,dPP);
  
  figure(1)
  plot3(vecteur_y_disparity(1,:), vecteur_y_disparity(2,:), vecteur_y_disparity(3,:),'g')
  hold on
  plot3(particule_disparity(1,:,1),particule_disparity(2,:,1),particule_disparity(3,:,1),'r+')

  figure(2)
  plot3(particule_real(1,:,1), particule_real(2,:,1), particule_real(3,:,1),'r+')
  hold on
  plot3(vecteur_x_real(1,:),vecteur_x_real(2,:),vecteur_x_real(3,:),'b')
  hold on


  
  %%P_kalm_disparity = ones(n,n,M); % Variance of the problem
  %%%I don't know how to make the next loop faster...
  %%for i = 1:M
  %%  P_kalm_disparity(:,:,i) = eye(n,n);
  %%end

  %%x_kalm_disparity_mean = ones(n,T); % store the real value
  %%x_kalm_real_mean = ones(n,T); % store the real value

  for k=1:T-1
    particule_real(:,:,k) = Markov_Kernel(F,Q,particule_real(:,:,k),n_particule);
    plot3(particule_real(1,:,k), particule_real(2,:,k), particule_real(3,:,k),'g+');
break
break
    samples_real = disparity_to_real(samples_disparity, f_d, b,dPP);
    samples_real_updated = transition_real(samples_real,samples_speed);
    samples_disparity_updated = real_to_disparity(samples_real_updated, f_d, b,dPP);
    [x_kalm_disparity(:,:,k+1) P_kalm_disparity ]= recover_gaussian(samples_disparity_updated,M);
    [x_kalm_disparity(:,:,k+1) P_kalm_disparity weight] = filtre_de_kalman_update( F, Q, H, R, vecteur_y_disparity(:,k),x_kalm_disparity(:,:,k), P_kalm_disparity,M,weight);
    
    x_kalm_disparity_mean(:,k+1) = weight*x_kalm_disparity(:,:,k+1)';
    x_kalm_real_mean(:,k+1) = disparity_to_real(x_kalm_disparity_mean(:,k+1), f_d, b,dPP);
  end
end