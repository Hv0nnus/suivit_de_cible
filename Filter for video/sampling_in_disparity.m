% give back sample from the M gaussians that are given
function [samples_disparity] = sampling_in_disparity(x_kalm_disparity_k, P_kalm_disparity_k,number_sampling,M)
  dimension = length(x_kalm_disparity_k(:,1))
  for m = 1:M
    samples_disparity(:,:,m) = (randn(number_sampling/M,dimension) * sqrtm(P_kalm_disparity_k(:,:,m)))'
    + repmat(x_kalm_disparity_k(:,m),number_sampling/M)
  end
end
