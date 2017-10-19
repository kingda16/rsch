%%Some testing code
% g = @(d,e) functional(d,e,onep,DX,dx);
% f = @(d,e) functional(d,e,twop,DX,dx);
% [X,Y]=meshgrid(linspace(0.1,2,10),linspace(0.005,0.02,10));
% Z = arrayfun(g,X,Y);
% Z1 = arrayfun(f,X,Y);
% clf
% surf(X,Y,Z)
% hold on
% surf(X,Y,Z1)

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
%guess = cos((0.5-X).^2+(0.5-Y).^2);
guess = X;
functional2d(delta,epsilon,guess,DX,dx)
