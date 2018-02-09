function [ x_kalm_k1, P_kalm_k1, weight_k1, n_k1] = filtre_de_kalman( F, Q, H, R, y_k,x_kalm_k, P_kalm_k,n_k,weight_k,ps,pd,lambda,nombre_gaussien_a_garder)

  %weight_k1 = zeros(1,n_k)
  n = 4;% nombre de dimension du problem
  n_gamma = 1;#?? Je ne sait tjs pas quel valeur mettre, mais c'est les nouveaux
  len_Z_k = size(y_k)(2);#nombre d'observation
  # n_k est le nombre de gaussien
  n_k1_k = n_gamma + n_k;
  n_k1 = (len_Z_k + 1)* n_k1_k;
  qd = 1 - pd;
  
  
  x_kalm_k1 = ones(n,n_k1);
  P_kalm_k1 = ones(n,n,n_k1);
  weight_k1 = ones(1,n_k1);
  
  for i=1:n_gamma
    l=i;
    x_kalm_k1_k([1 3],l) = 500*rand(2,1);
    x_kalm_k1_k([2 4],l) = [4,3];
    P_kalm_k1_k(:,:,l) = 100*eye(n,n);
    weight_k1_k(l) = 0.0001;
  end

  #On boucle comme dans l article pour faire la prediction
  for j=1:n_k
    l = n_gamma + j;
    x_kalm_k1_k(:,l) = F*x_kalm_k(:,j);
    P_kalm_k1_k(:,:,l) = F*P_kalm_k(:,:,j)*F'+Q;
    weight_k1_k(l) = ps * weight_k(j);
  end




  incr_i = n_k1_k; #indice qui dit a quel endroit on doit placer la gaussienne suivant
  for l=1:n_k1_k
    weight_k1(l) = qd * weight_k1_k(l);
    x_kalm_k1(:,l) = x_kalm_k1_k(:,l);
    P_kalm_k1(:,:,l) = P_kalm_k1_k(:,:,l);
    
    K_n = P_kalm_k1_k(:,:,l)*H'/(H*P_kalm_k1_k(:,:,l)*H'+ R) ;
    for j=1:len_Z_k
      incr_i = incr_i + 1;
      i = l * n_k1_k + j;
      
      x_kalm_k1(:,incr_i) = x_kalm_k1_k(:,l) + K_n*(y_k(:,j) - H*x_kalm_k1_k(:,l));

      P_kalm_k1(:,:,incr_i) = (eye(n,n) - K_n*H)*P_kalm_k1_k(:,:,l);      
      somme = 0;
      for l_2 = 1:n_k1_k
        somme = somme + pd * weight_k1_k(l_2) * mvnpdf(y_k(:,j)',(H*x_kalm_k1_k(:,l_2))',H*P_kalm_k1_k(:,:,l_2)*(H')+R);
      end
      somme
      (lambda + somme)
      weight_k1(1,incr_i) = (weight_k1_k(l)* pd * mvnpdf(y_k(:,j)',(H*x_kalm_k1_k(:,l))',H*P_kalm_k1_k(:,:,l)*(H')+R))/(lambda + somme);
    end
  end

  weight_k1 = weight_k1/sum(weight_k1);

  weight_k1
  x_kalm_k1
  P_kalm_k1
  while(nombre_gaussien_a_garder < size(weight_k1)(2))
    [minimum,indice_minimum] = min(weight_k1);
    weight_k1(indice_minimum) = [];
    x_kalm_k1(:,indice_minimum) = [];
    P_kalm_k1(:,:,indice_minimum) = [];
  end
  n_k1 = size(weight_k1)(2);
  P_kalm_k1;
end

