%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   CalcVarExample
%
%   This code computes the curve that minimizes the distance between two
%   points. 
%
%
%   Parameters:
%   1. n = number of sample points
%   2. y1 = y starting coordinate
%   3. y2 = y ending coordiante
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameters
n=200;
y1=0;
y2=0;

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
%guess=x(2:end-1);
%guess = sin(2*pi*x(2:end-1));
%guess=x(2:end-1).*(1-x(2:end-1));
%guess = saved;
%guess=ones(1,n-2);
%guess = [x(2:70) 1-x(71:150) x(151:end-1)];



%% Optimization Routine
options=optimset('MaxFunEvals',1e+9,'MaxIter',10^3,'Display','iter');
% 
delta = 5; %try 0.001 vs 1
epsilon = 0.01;
g = @(f) functional(delta,epsilon,f,DX,dx);
x0 = guess;
ub = ones(1,n-2)*10;
lb = ones(1,n-2)*-10;
[x,opt] = fmincon(g,x0,[],[],[],[],lb,ub,[],options);
plot(x);
ylim([-1 1])


    

%% Plotting Result
%plot(x,yguess,'r',x,4*x,'b',x,y,'g--');
