function [ Y ] = bruit_gaussien( X,cl1,cl2,m1,sig1,m2,sig2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n = size(X);
b = randn(n);
Y = X + (sig1 * b + m1) .* (X == cl1) + (sig2 * b + m2) .* (X == cl2);

return Y
end

