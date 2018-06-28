function [ x_kalm_k,P_kalm_k ] = filtre_de_kalman( F,Q,H,R,y_k,x_kalm_prec,P_kalm_prec)

mk_kprec=F*x_kalm_prec;%prédiction
Pk_kprec=F*P_kalm_prec*transpose(F)+Q;%prédiction

if isnan(y_k) 
    x_kalm_k=mk_kprec;
    P_kalm_k=Pk_kprec;
else
    %K_k=Pk_kprec*transpose(H)/(H*Pk_kprec*transpose(H)+R);
    K_k=Pk_kprec*transpose(H)*inv(H*Pk_kprec*transpose(H)+R);
    x_kalm_k=mk_kprec+K_k*(y_k-H*mk_kprec);%mise à jour
    P_kalm_k=(eye(4)-K_k*H)*Pk_kprec;%mise à jour
end
end
