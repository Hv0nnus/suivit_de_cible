function [mean covar] = recover_gaussian (particule)
particule = particule';
covar = cov(particule);
mean = mean(particule);
end
