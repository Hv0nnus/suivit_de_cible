%
%
% Mod�le de Kitagawa, equation d'�tat
%
function res = transition(x,n)

res = 0.5.*x + 25.*(x/(1+x.^2)) + 8*cos(1.2*n);

end

