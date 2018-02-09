function vecteur_x = creer_trajectoire(x0, T, Q)

vecteur_x = zeros(1,T);
vecteur_x(1)=x0;


for i=1:T-1
    
U = sqrt(Q) * randn(1,1);
vecteur_x(i+1) = transition(vecteur_x(:,i),i+1) + U;
    
end



end

