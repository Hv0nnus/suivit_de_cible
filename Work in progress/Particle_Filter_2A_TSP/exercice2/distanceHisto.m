function dist = distanceHisto(historef, histo)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Nb = length(historef);
dist = sqrt(1 - sum(sqrt(historef.*histo)));

end

