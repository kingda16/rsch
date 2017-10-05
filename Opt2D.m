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
n=20;
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
[X,Y] = meshgrid(linspace(0,1,n-2),linspace(0,1,n-2));
%guess = [X(:,1:n/2) 1-X(:,n/2+1:end)]+[Y(1:n/2,:); 1-Y(n/2+1:end,:)];
guess = cos(4*pi*X)+cos(4*pi*Y);



%% Optimization Routine
options=optimset('MaxFunEvals',1e+9,'MaxIter',10^3,'Display','iter');
% 
delta = 100; %try 0.001 vs 1
epsilon = 0.1;
g = @(f) functional2d(delta,epsilon,f,DX,dx);
x0 = guess;
ub = ones(n-2,n-2)*10;
lb = ones(n-2,n-2)*-10;
[x,opt] = fmincon(g,x0,[],[],[],[],lb,ub,[],options);
x = [zeros(1,n); zeros(n-2,1) x zeros(n-2,1); zeros(1,n)];
surf(x)



    

%% Plotting Result
%plot(x,yguess,'r',x,4*x,'b',x,y,'g--');
