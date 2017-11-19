function [eq , eqm] = erreur_quadratique_moyenne(x, x_est, T )


dx= (x - x_est).^2;

eq = dx;

eqm = sum(eq)*1/T;

end