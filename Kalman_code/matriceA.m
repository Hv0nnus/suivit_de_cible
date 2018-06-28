clear all
a = 0;
b = pi;
alpha = 2;
beta = 0;
N = 10;

for N=2:100;
    A = GA(N);
    condA(N)=cond(A);
    %N;
end;
figure(1);
%size(condA)
%size(1:100)
plot(1:100,condA, 'r'); title('Conditionnement');

N=20;
[A,v,u,ue,x] = GA(N);
figure(2);
plot(x,u,'r',x,ue,'--b'); legend('u','ue')
erru=u-ue;
figure(3);
plot(x,erru);
title('Erreur');
xlabel('x');

clear erru
for N=2:100;
   x(N)=N
   [A,v,u,ue,x] = GA(N);
   erru(N)=max(abs(u-ue));
   h = (b-a)/(N+1);
   erruh2(N)=erru(N)/h^2;
end

figure(4);
plot(x,erru,'b',x,erruh2,'r');