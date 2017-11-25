% This function will apply Kalman filter in 3D space
% vecteur_x should not be here but we will use it to plot
function [x_kalm_mean,x_kalm] = Kalman_New_Dimension (M,H,T,F,MQ,Q,R,x_init,vecteur_y_disparity,variance_initial,number_sampling,f_d, b,dPP);
  
  n = 6;% length(x_init); % Dimension of the disparity space
  
  weight = ones(1,M)/M; % weight of the Gaussians
  x_kalm_disparity = zeros(n,M,T); %We will store the value of gaussian in disparity space here
  U = randn(3,M) * sqrtm(eye(M)*variance_initial) + repmat(vecteur_y_disparity(:,1),1,M); % start of different Gaussians
  x_kalm_disparity(:,:,1) = U; % put of start value to the vector that will store the position
  P_kalm_disparity = ones(n,n,M); % Variance of the problem
  %I don't know how to make the next loop faster...
  for i = 1:M
    P_kalm_disparity(:,:,i) = eye(n,n);
  end

  x_kalm_disparity_mean = ones(n,T); % store the real value
  x_kalm_real_mean = ones(n,T); % store the real value

  for k=1:T-1
    samples_disparity = sampling_in_disparity(x_kalm_disparity(:,:,k), P_kalm_disparity(:,:,k),number_sampling);
    samples_real = disparity_to_real(samples_disparity, f_d, b,dPP);
    samples_real_updated = transition_real(samples_real,samples_speed);
    samples_disparity_updated = real_to_disparity(samples_real_updated, f_d, b,dPP);
    [x_kalm_disparity(:,:,k+1) P_kalm_disparity ]= recover_gaussian(samples_disparity_updated,M);
    [x_kalm_disparity(:,:,k+1) P_kalm_disparity weight] = filtre_de_kalman_update( F, Q, H, R, vecteur_y_disparity(:,k)),x_kalm_disparity(:,:,k), P_kalm_disparity,M,weight);
    
    x_kalm_disparity_mean(:,k+1) = weight*x_kalm_disparity(:,:,k+1)';
    x_kalm_real_mean(:,k+1) = disparity_to_real(x_kalm_disparity_mean(:,k+1), f_d, b,dPP);
  end
end