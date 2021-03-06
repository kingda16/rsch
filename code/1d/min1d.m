%% Parameters
n=100;


%% Construction of parametrization domain and differential operators
x=linspace(0,1,n);
dx=x(2)-x(1);

%%%%%%%%%%%% Construction of first derivative approximation

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


%% Construction of initial profile;
%guess = sin(pi*x(2:end-1));
guess = x(2:end-1);



%% Optimization Routine
options=optimset('MaxFunEvals',1e+9,'MaxIter',10^3,'Display','iter');
% 
delta = 0; %try 0.001 vs 1
epsilon = 0.1;
g = @(f) functional1d(delta,epsilon,[0 f 0],DX,dx);
x0 = guess;
ub = ones(1,n-2)*10;
lb = ones(1,n-2)*-10;
[x,opt] = fmincon(g,x0,[],[],[],[],lb,ub,[],options);

