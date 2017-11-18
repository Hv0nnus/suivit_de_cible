% This function will apply Kalman filter in 3D space
% vecteur_x should not be here but we will use it to plot
function [x_kalm_mean,x_kalm] = Kalman_New_Dimension (M,H,T,F,MQ,Q,R,x_init,vecteur_y,variance_initial)
  
  weight = ones(1,M)/M; % weight of the Gaussians
  weight_init = weight;
  x_kalm = zeros(length(x_init),M,T); %We will store the value here
  U = randn(3,M) * sqrtm(eye(M)*variance_initial) + repmat(vecteur_y(:,1),1,M); % start of diferent Kalman
  x_kalm([1,3,5],:,1) = U; % put of start value to the vector that will store the position
  P_kalm = ones(length(x_init),length(x_init),M); % Variance of the problem
  %I don't know how to make the next loop faster...
  for i = 1:M
    P_kalm_temporary(:,:,i) = eye(length(x_init),length(x_init));
  end

  x_kalm_mean = ones(length(x_init),T); % store the real value
  x_kalm_mean(:,1) = weight*x_kalm(:,:,1)';

  for k=1:T-1
    y_k=vecteur_y(:,k+1);
    [x_kalm(:,:,k+1) P_kalm weight] = filtre_de_kalman( F, Q, H, R, y_k,x_kalm(:,:,k), P_kalm,M,weight);
    x_kalm_mean(:,k+1) = weight*x_kalm(:,:,k+1)';
  end


end
