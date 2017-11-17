
% x = matrice 2x50 (correspond à x_(k-1) pour i = 1 à N qui regroupe les
% coordonnés du points haut gauche
% yk = la dernière observation en mémoire (histogramme) 10*50
% w = les poids
% C1, C2 les variances respectivement pour l'abscisse et l'ordonnée
% lambda = paramètre de la loi expo 
% histoRef = histogramme de reference
function  [ particule, poids_norm, estimateur ] = filtrage_particulaire(im, l1, l2, x,w,C1,C2,lambda, histoRef, Cmap, k)



abs = x(1,:);
ord = x(2,:);
N = length(abs);
Nb = max(size(Cmap));

% 
% newHisto = zeros(Nb, N);
abs_new = abs + randn(1,N)*sqrt(C1);
ord_new = ord + randn(1,N)*sqrt(C2);

poids = zeros(1,N);

particule = [abs_new; ord_new];



for i=1:N
    zoneAT = [abs_new(i); ord_new(i); l1; l2];
    [littleim,NewCmap, histo_i]=calcul_histogramme(im,zoneAT,Cmap);
    histo_i = histo_i./sum(histo_i);
%     newHisto(i,:) = histo_i;
    poids(i) = w(i).* exp(-lambda*(distanceHisto(histoRef, histo_i))^2);
end
    
% for i in 1:N
%     histo = histo_init(:,i);
%     poids(i) = w.* exp(-lambda*(distanceHisto(histoRef, histo))^2);
% end

poids_norm = poids./(sum(poids));


abs_est = sum(poids_norm.*abs_new);
ord_est = sum(poids_norm.*ord_new);
estimateur = [abs_est, ord_est];



[particule, poids_norm] = reechantillonage(particule, poids_norm);

end