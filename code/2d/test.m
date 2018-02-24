x=linspace(0,1,n);
dx=x(2)-x(1);
[x,y] = meshgrid(x,x);

gflow2d(0,0.1,30,100,2*10^-2,seedgen(30,'trig',1,1),sin(3*pi*x).*sin(3*pi*y),'QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ')