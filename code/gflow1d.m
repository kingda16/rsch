%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Dylan King
%
%   1-dimensional gradient flow
%
%

%% Parameters
n=200;
M=100;
T=0.01;

%% Construction of domain and differential operators
x=linspace(0,1,n);
t=linspace(0,T,M);
dx=x(2)-x(1);


DX=(1*diag(ones(1,n-2),-2)-8*diag(ones(1,n-1),-1)+8*diag(ones(1,n-1),1)-1*diag(ones(1,n-2),2));

DX(1,1)=-25;
DX(1,2)=48;
DX(1,3)=-36;
DX(1,4)=16;
DX(1,5)=-3;

DX(2,1)=-3;
DX(2,2)=-10;
DX(2,3)=18;
DX(2,4)=-6;
DX(2,5)=1;

DX(n,n)=25;
DX(n,n-1)=-48;
DX(n,n-2)=36;
DX(n,n-3)=-16;
DX(n,n-4)=3;

DX(n-1,n)=3;
DX(n-1,n-1)=10;
DX(n-1,n-2)=-18;
DX(n-1,n-3)=6;
DX(n-1,n-4)=-1;

DX=1/(12*dx)*DX;
DX = sparse(DX);

DXX=-2*diag(ones(n,1),0)+diag(ones(n-1,1),1)+diag(ones(n-1,1),-1);
DXX=DXX/(dx.^2);

DXX=sparse(DXX);

%% Construction of initial profile
guess= 0.9*x;
%guess = sin(2*pi*x);
options = odeset('Stats','on','OutputFcn',@odeplot)
[t,u] = ode45(@(t,u) grad1d(t,u,DX,DXX,1,1),t,guess,options);
plot(u(end,:))

