%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Water and Ice Example
%
%   This code computes the evolution of a solution to a simple model of
%   phase transitions on a square domain with with Dirichlet boundary
%   conditions. The specific PDE we look at is given by:
%
%   u_t=Du_{xx}+Du_{yy}+u-u^3
% 
%
%   Parameters:
%   1. n = number of sample points
%   2. D= diffusion coefficient
%   5. M=number of sample points in time
%   6. T= maximum time
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
%% Parameters
n=200;
D=.1;
M=100;
T=.2;

%% Construction of domain and differential operators
x=linspace(0,1,n);
y=linspace(0,1,n);

[X,Y]=meshgrid(x,y);

t=linspace(0,T,M);
dx=x(2)-x(1);
dy=y(2)-y(1);

D2=-2*diag(ones(n,1),0)+diag(ones(n-1,1),1)+diag(ones(n-1,1),-1);

DXX=D2/(dx.^2);
DYY=D2/(dy.^2);

DXX=sparse(DXX);
DYY=sparse(DYY);


%% Construction of initial profile
guess=sin(sqrt(2)*pi*X).^2.*cos(sqrt(2)*pi*Y);
guess=reshape(guess,[n*n,1]);

%% Solving System of ODEs

[t,u] = ode45(@(t,u) WIODE(t,u,D,DXX,DYY,n),t,guess);



vidObj = VideoWriter('WI.avi');
open(vidObj);

figure('units','normalized','outerposition',[0 0 1 1]);
for k=1:M,
        clf;
        
        uplot=reshape(u(k,:),[n,n]);
        
    contourf(X,Y,uplot);

xlabel('$$x$$','interpreter','latex','fontsize',40)
    ylabel('$$y$$','interpreter','latex','fontsize',40)
    string=strcat('$D$=',num2str(D));
    title(string,'interpreter','latex','fontsize',40)

    set(gcf,'color','w');
colorbar;
caxis([-1,1]);
	

    axis([0,1,0,1]);
shg;

    currFrame = getframe(gcf);
    writeVideo(vidObj,currFrame);
    
end

toc
close(vidObj);

