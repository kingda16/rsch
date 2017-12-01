
n = 30;
delta = 0.1;
epsilon = 0.1;

t=linspace(0,T,M);

x=linspace(0,1,n);
dx=x(2)-x(1);
[x,y] = meshgrid(x,x);



%identity ui-1+ui+1==2ui at bdry





%% Construction of initial profile


guess = sin(pi*x).*sin(pi*y);

options = optimoptions('fminunc','SpecifyObjectiveGradient',true)


x = fminunc(@minmovf,guess,options)






