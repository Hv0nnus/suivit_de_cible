function [eq , eqm] = mean_erreur_quadratique_suj(x, x_est, T )


dx= (x - x_est).^2;

eq = dx(1,:) + dx(2,:) + dx(3,:);% + dx(4,:);

eqm = sum(sqrt(eq))*(1/T);

end