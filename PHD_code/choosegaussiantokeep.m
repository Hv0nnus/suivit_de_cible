function [kalmanToKeep weight] = choosegaussiantokeep (weight,x_kalm_k,P_kalm_k,M,threshold,k)
  kalmanToKeep = 1:M;
  #Double boucle et si on a deux valeur trop proche, on supprime une des deux.
  for j=1:M
      for i=1:j-1
          d_j_i= gaussianDistance(x_kalm_k(:,j),x_kalm_k(:,i),P_kalm_k(:,:,j),P_kalm_k(:,:,i));
          if(d_j_i < threshold)
            k
            weight(j) = weight(j) + weight(i);
            kalmanToKeep = kalmanToKeep(kalmanToKeep~=i);
          end
        end
      end
end
