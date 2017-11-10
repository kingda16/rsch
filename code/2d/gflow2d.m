function [] = gflow2d( delta,epsilon,n,M,T )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Dylan King
%
%   2-dimensional gradient flow
%
%


%% Construction of domain and differential operators
t=linspace(0,T,M);

x=linspace(0,1,n);
dx=x(2)-x(1);
[x,y] = meshgrid(x,x);
guess = zeros(n,n);


%identity ui-1+ui+1==2ui at bdry


DX=(-1*diag(ones(1,n-1),-1)+1*diag(ones(1,n-1),1));
DX(1,1) = -2;
DX(1,2) = 2;
DX(end,end) = 2;
DX(end,end-1) = -2;


DXX=(1*diag(ones(1,n-1),-1)+1*diag(ones(1,n-1),1)-2*diag(ones(1,n)));
DXX(1,1) = 0;
DXX(1,2) = 0;
DXX(end,end) = 0;
DXX(end,end-1) = 0;

DXXXX=(1*diag(ones(1,n-2),-2)+1*diag(ones(1,n-2),2)-4*diag(ones(1,n-1),-1)-4*diag(ones(1,n-1),1)+6*diag(ones(1,n)));
DXXXX(1,1) = -5;
DXXXX(1,2) = 14;
DXXXX(1,3) = -14;
DXXXX(1,4) = 6;
DXXXX(1,5) = -1;

DXXXX(end,end) = -5;
DXXXX(end,end-1) = 14;
DXXXX(end,end-2) = -14;
DXXXX(end,end-3) = 6;
DXXXX(end,end-4) = -1;

DXXXX(2,1) = -2;
DXXXX(2,2) = 5;
DXXXX(2,3) = -4;
DXXXX(2,4) = 1;

DXXXX(end-1,end) = -2;
DXXXX(end-1,end-1) = 5;
DXXXX(end-1,end-2) = -4;
DXXXX(end-1,end-3) = 1;


DX=1/(2*dx)*DX;
DXX = 1/(dx^2)*DXX;
DXXXX=1/(dx^4)*DXXXX;

DXXXX = sparse(DXXXX);
DXX = sparse(DXX);
DX = sparse(DX);

%% Construction of initial profile
for i = 1:n
    for j = 1:n
        guess(i,j) = max([0.4*power(10*x(1,i).*(1-x(1,i)).*(1-y(j,1)).*y(j,1),1/4),min([min([1-x(1,i),1-y(j,1),x(1,i)]),1-max([1-x(1,i),1+0.2-y(j,1),x(1,i)])])]);
    end
end


guess = power(10*x.*(1-x).*(1-y).*y,1/4)+0.1*sin(7*pi*x).*sin(7*pi*y);
%guess = 0.25*sin(7*pi*x).*sin(7*pi*y);

guess(1,:) = 0; 
guess(end,:) = 0;
guess(:,1) = 0;
guess(:,end) = 0;


guess=reshape(guess,[n*n,1]);

options = odeset('Stats','on')
[t,u] = ode45(@(t,u) grad2d(t,u,DX,DXX,DXXXX,delta,epsilon,n),t,guess,options);

save(strcat('./data/e',num2str(epsilon),'d',num2str(delta),'n',num2str(n),'m',num2str(M),'t',num2str(T),'.mat'),'u','t','x','y','M','T','n','epsilon','delta');

end

