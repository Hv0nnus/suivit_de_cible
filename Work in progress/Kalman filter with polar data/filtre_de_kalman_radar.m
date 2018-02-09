function [ x_kalm_k, P_kalm_k] = filtre_de_kalman_radar( F, Q, R, y_k,x_kalm_prec, P_kalm_prec)

%%% Estimation de la position à l'instant k connaissant les k observations
%%% Meilleur estimateur espérance de p(xn/y0:n)
%%% Kalman estimateur mn/n

%%% On définit kn


n = length(x_kalm_prec);


if isnan(y_k)
    
    x_kalm_k = F*x_kalm_prec;
    P_kalm_k = F*P_kalm_prec*F'+Q;
    
else
    
    P_n_npr = F*P_kalm_prec*F'+Q;
    m_n_npr = F*x_kalm_prec;
    
    x = m_n_npr(1);
    y = m_n_npr(3);
    H = [ -y*1/((1+(y/x)^2)*(x.^2)) 0 1/((1+(y/x)^2)*x) 0;
          x/(sqrt(x^2 + y^2)) 0 y/(sqrt(x^2 + y^2)) 0];
      
    y_k_prime = y_k - [ atan(y/x); sqrt(x^2 +y^2)] + H*m_n_npr ; 
    y_k_tilde = y_k_prime - H*m_n_npr ;
      
    K_n = P_n_npr*H'/(H*P_n_npr*H'+ R) ;
    x_kalm_k = m_n_npr + K_n*(y_k_tilde);
    P_kalm_k=(eye(n,n) - K_n*H)*P_n_npr;
   
end 

end