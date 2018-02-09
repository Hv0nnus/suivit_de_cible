% give back sample from the M gaussians that are given
function [particule_real] = Markov_Kernel( F, Q,particule_real,n_particule)

n = 3;
for n=1:n_particule
  U = sqrtm(Q) * randn(3,1);
  %U = [ 0 ; 0 ; 0 ];
  %U = 0.01*randn(3,1);
  particule_real(1:3,n) = F * particule_real(1:3,n) + U;      
end

end
