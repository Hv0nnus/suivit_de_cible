
N = 200;
figure (1)
x = 0:(N-1);
y = rand(1, length(x));
plot(x(1), y(1));
axis([0 N 0 1]);
vh = get(gca,'children');
for i=1:length(x)
        set(vh, 'xdata',x(1:i), 'ydata', y(1:i));
        pause(0.1)
endfor 