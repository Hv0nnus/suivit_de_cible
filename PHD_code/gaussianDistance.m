function [d] = gaussianDistance (m1,m2,sig1,sig2)
  d = sqrt(norm(m1-m2));
  %+ trace(sig1 + sig2 - 2*sqrtm(sqrtm(sig1)*sig2*sqrtm(sig1))));
end
