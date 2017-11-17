function [im,filenames,T,SEQUENCE]=lecture_image

SEQUENCE = './sequence2/' ;
START = 1 ;
% charge le nom des images de la s�equence
filenames = dir([SEQUENCE '*.png']) ;
%filenames = sort(filenames.name) ;
T = length(filenames) ;
% charge la premiere image dans �im�
tt = START ;
im = imread([SEQUENCE filenames(tt).name]) ;
% affiche �im�
figure ;
set(gcf, 'DoubleBuffer', 'on') ;
imagesc(im) ;
hold on