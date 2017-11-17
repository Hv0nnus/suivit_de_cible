clear all
close all
clc

N=50; 
Nb =10;
lambda = 20;
C1= 300;
C2 = 300;

sigma_partic = sqrt(300);

[im,filenames,T,SEQUENCE]=lecture_image;
zone_init =  selectionner_zone;

% abscisse
parti_0_1 = randn(1,N)*sigma_partic + zone_init(1);
% Ordonnée
parti_0_2 = randn(1,N)*sigma_partic + zone_init(2);

x_init = [parti_0_1; parti_0_2 ];

[littleim,Cmap,histoRef]=calcul_histogramme(im,zone_init,Nb);
histoRef = histoRef./sum(histoRef); 
X_est = [zone_init(1) zone_init(2)];

l1 = zone_init(3);
l2 = zone_init(4);

particule = x_init;
poids_norm = ones(1,N)/N;
x_est = [zone_init(1); zone_init(2)];
for i=2:T
    img = imread([SEQUENCE filenames(i).name]); 
    [ particule, poids_norm, x_est ] = filtrage_particulaire(img,l1,l2, particule, poids_norm, C1, C2, lambda, histoRef, Cmap, i);
    X_est = [X_est; x_est];
end

plot(X_est)