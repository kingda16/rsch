%%Some testing code
g = @(d,e) functional(d,e,onep,DX,dx);
f = @(d,e) functional(d,e,twop,DX,dx);
[X,Y]=meshgrid(linspace(0.1,2,10),linspace(0.005,0.02,10));
Z = arrayfun(g,X,Y);
Z1 = arrayfun(f,X,Y);
clf
surf(X,Y,Z)
hold on
surf(X,Y,Z1)