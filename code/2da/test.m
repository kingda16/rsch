n = 30;
x=linspace(0,1,n);
dx=x(2)-x(1);
[x,y] = meshgrid(x,x);


gflow2d(0,0.1,n,100,10^-1,0.1*seedgen(n,'trig',1,1),zeros(n,n),ones(n,n),'QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ')