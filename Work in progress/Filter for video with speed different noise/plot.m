  if(all_particule)
    k = 1:n_particule;
  else
    k = 1:n_particule;
  end
f1 = figure(1)
    %axis([-1000 1000 -1000 1000 -1000 1000])
    for t=1:40
      if(t~=30)
      plot3(vecteur_x_real(1,1:t), vecteur_x_real(3,1:t), vecteur_x_real(5,1:t),'b')
      hold on
      plot3(vecteur_y_real(1,1:t),vecteur_y_real(2,1:t),vecteur_y_real(3,1:t),'g')
      hold on
      plot3(x_kalm_real(1,1:t),x_kalm_real(3,1:t),x_kalm_real(5,1:t),'r')
      hold on
      plot3(particule_real(1,k,t),particule_real(3,k,t),particule_real(5,k,t),'m.','MarkerSize', 6)
      hold on
      
      drawnow;
      %print(f1,strcat("Reel_Gif",int2str(t),".png"))
      %pause(0.01);
      if(all_particule)
        hold off  
      end
      if(t==T)
        hold off  
      end
      end
    end
  azegsfd
f2 = figure(2)
A = 1:100;
plot3(vecteur_x_real(1,A), vecteur_x_real(3,A), vecteur_x_real(5,A),'b')
hold on
plot3(vecteur_y_real(1,A),vecteur_y_real(2,A),vecteur_y_real(3,A),'g')
hold on
plot3(x_kalm_real(1,A),x_kalm_real(3,A),x_kalm_real(5,A),'r')
hold on
size(x_kalm_real(1,A))
for k=1:n_particule
  size(particule_real(1,k,A))
  size(particule_real(3,k,A))
  size(particule_real(5,k,A))
  a = zeros(1,100);
  b = zeros(1,100);
  c = zeros(1,100);
  a(1,100) = particule_real(1,k,A);
  b(1,100) = particule_real(3,k,A);
  c(1,100) = particule_real(5,k,A);
  
  %plot3(particule_real(1,k,A),particule_real(3,k,A),particule_real(5,k,A),'m.','MarkerSize', 6)
  plot3(a,b,c,'m.','MarkerSize', 6)
  hold on
end
drawnow
print(f2,"aaaa.png")


if 1==0
A = 1:10;
f3 = figure(3)
plot3(vecteur_x_real(1,A), vecteur_x_real(3,A), vecteur_x_real(5,A),'b')
hold on
plot3(vecteur_y_real(1,A),vecteur_y_real(2,A),vecteur_y_real(3,A),'g')
hold on
plot3(x_kalm_real(1,A),x_kalm_real(3,A),x_kalm_real(5,A),'r')
hold on
print(f3,strcat("PFE_start_2.png"))

A = 10:50;
f4 = figure(4)
plot3(vecteur_x_real(1,A), vecteur_x_real(3,A), vecteur_x_real(5,A),'b')
hold on
plot3(vecteur_y_real(1,A),vecteur_y_real(2,A),vecteur_y_real(3,A),'g')
hold on
plot3(x_kalm_real(1,A),x_kalm_real(3,A),x_kalm_real(5,A),'r')
hold on
print(f4,strcat("PFE_middle_2.png"))

A = 70:100;
f5 = figure(5)
plot3(vecteur_x_real(1,A), vecteur_x_real(3,A), vecteur_x_real(5,A),'b')
hold on
plot3(vecteur_y_real(1,A),vecteur_y_real(2,A),vecteur_y_real(3,A),'g')
hold on
plot3(x_kalm_real(1,A),x_kalm_real(3,A),x_kalm_real(5,A),'r')
hold on
print(f5,strcat("PFE_end_2.png"))

end
