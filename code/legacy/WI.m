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
n=30;
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


%% Construction of initial profile
guess=sin(pi*X(2:end-1,2:end-1))*sin(pi*Y(2:end-1,2:end-1));
delta = 1;
epsilon = 1;


%% Solving System of ODEs

[t,u] = ode45(@(t,u) WIODE(delta,epsilon,u,DX,dx),t,guess);
uplot=reshape(u(end,:),[n-2,n-2]);
surf(uplot)


% vidObj = VideoWriter('WI.avi');
% open(vidObj);

% figure('units','normalized','outerposition',[0 0 1 1]);
% for k=1:M,
%         clf;
%         
%         uplot=reshape(u(k,:),[n,n]);
%         
%     contourf(X,Y,uplot);
% 
% xlabel('$$x$$','interpreter','latex','fontsize',40)
%     ylabel('$$y$$','interpreter','latex','fontsize',40)
%     string=strcat('$D$=',num2str(D));
%     title(string,'interpreter','latex','fontsize',40)
% 
%     set(gcf,'color','w');
% colorbar;
% caxis([-1,1]);
% 	
% 
%     axis([0,1,0,1]);
% shg;
% 
%     currFrame = getframe(gcf);
%     writeVideo(vidObj,currFrame);
%     
% end

% toc
% close(vidObj);

