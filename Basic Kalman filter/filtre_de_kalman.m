function [ x_kalm_k, P_kalm_k] = filtre_de_kalman( F, Q, H, R, y_k,x_kalm_prec, P_kalm_prec)

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
    K_n = P_n_npr*H'/(H*P_n_npr*H'+ R) ;
    m_n_npr = F*x_kalm_prec;

    x_kalm_k = m_n_npr + K_n*(y_k - H*m_n_npr);
    P_kalm_k=(eye(n,n) - K_n*H)*P_n_npr;
   
end 

end

