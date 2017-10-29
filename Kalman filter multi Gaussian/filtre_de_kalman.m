function [ x_kalm_k, P_kalm_k weight] = filtre_de_kalman( F, Q, H, R, y_k,x_kalm_prec, P_kalm_prec,M,weight)

%%% Estimation de la position à l'instant k connaissant les k observations
%%% Meilleur estimateur espérance de p(xn/y0:n)
%%% Kalman estimateur mn/n

%%% On définit kn


n = 4;% c'est quoi n ?


if isnan(y_k)
  x_kalm_k = ones(n,M);
  P_kalm_k = ones(n,n,M);
  for j=1:M
    %Just chose the good kalman prediction for this gaussian
    x_kalm_prec_j = x_kalm_prec(:,j);
    P_kalm_prec_j = P_kalm_prec(:,:,j);
    
    %Prediction
    x_kalm_k(:,j) = F*x_kalm_prec_j; % On peut le faire au dessus 
    P_kalm_k(:,:,j) = F*P_kalm_prec_j*F'+Q; % de meme
  end
    
else
    x_kalm_k = ones(n,M);
    P_kalm_k = ones(n,n,M);
    P_kalm_prec(:,:,:); %Pourquoi ?
    for j=1:M
      %Just chose the good kalman prediction for this gaussian
      x_kalm_prec_j = x_kalm_prec(:,j);
      P_kalm_prec_j = P_kalm_prec(:,:,j);
      
      %Prediction
      m_n_npr = F*x_kalm_prec_j;
      P_n_npr = F*P_kalm_prec_j*F'+Q;
      
      %Mise a jour
      K_n = P_n_npr*H'/(H*P_n_npr*H'+ R) ;
      x_kalm_k(:,j) = m_n_npr + K_n*(y_k - H*m_n_npr);
      P_kalm_k(:,:,j) = (eye(n,n) - K_n*H)*P_n_npr;

      weight(j) = weight(j)*mvnpdf(y_k',(H*m_n_npr)',H*P_n_npr*(H')+R);
    end
    weight = weight/sum(weight);
end 

end

