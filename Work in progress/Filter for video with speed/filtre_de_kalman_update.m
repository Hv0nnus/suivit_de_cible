function [ x_kalm_k, P_kalm_k weight] = filtre_de_kalman_update(H, R, y_k,x_kalm_prec, P_kalm_prec)

%%% Estimation de la position à l'instant k connaissant les k observations
%%% Meilleur estimateur espérance de p(xn/y0:n)
%%% Kalman estimateur mn/n

%%% On définit kn
%y_k
%x_kalm_prec
%P_kalm_prec


n = 6;

%Prediction
m_n_npr = x_kalm_prec;
P_n_npr = P_kalm_prec;

%Mise a jour
K_n = P_n_npr*H'/(H*P_n_npr*H'+ R) ;
x_kalm_k = m_n_npr + K_n*(y_k - H*m_n_npr);
P_kalm_k = (eye(n,n) - K_n*H)*P_n_npr;
%x_kalm_k
%P_kalm_k
end