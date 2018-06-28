function [vecteur_x, nombre_cible]= creat_trajectoire(F, Q, x_init, T,beta,ps)

  
  vecteur_x = cell(T,1);
  nombre_cible = zeros(T,1);
  nombre_naissance = zeros(T,1);
  
  for i=1:(T-1)
    nombre_de_naissance_i = poissrnd(beta);
    
    if(i==1)
      nombre_naissance(i) = 1; #on fait tjs une naissance pour commencer
      for k=1:nombre_naissance(i)
        vecteur_x{i}([1 3],k) = 150*rand(2,1)+[250;250];
        vecteur_x{i}([2 4],k) = [4,3];#la vitesse est fixé
      end
    else
      nombre_naissance(i) = nombre_de_naissance_i + nombre_naissance(i-1);
      for k=nombre_naissance(i-1)+1:nombre_naissance(i)
        vecteur_x{i}([1 3],k) = 150*rand(2,1)+[250;250];

        vecteur_x{i}([2 4],k) = [4,3];
      end
    end
    
    incr_j = 0;#sert a calculer ou on met les nouveaux element dans vecteur_x
    for j=1:nombre_naissance(i)
      disparition = (1-ps) < rand();
      if(disparition || (incr_j ==0 && j == nombre_naissance(i))) # Si on a tout supprimer, on garde forcement la derniere
        incr_j = incr_j + 1;
        nombre_cible(i) = nombre_cible(i) + 1;
        U = sqrtm(Q) * randn(4,1);
        vecteur_x{i+1}(:,incr_j) = F * vecteur_x{i}(:,j) + U;
      #else
        #vecteur_x{i+1}(:,j) = [NaN,NaN,NaN,NaN]';
      end
    end
    nombre_naissance(i) = nombre_cible(i,1);
  end
end

