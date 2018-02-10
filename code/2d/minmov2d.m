function [] = minmov2d( delta,epsilon,n,M)


tres = 10^-0;


x=linspace(0,1,n);
dx=x(2)-x(1);
[x,y] = meshgrid(x,x);

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



guess = 0.5*sin(x*pi).*sin(y*pi);



u = zeros(M,n^2);
u(1,:) = reshape(guess,[n^2,1]);


options = optimoptions('fminunc','Display','iter','Algorithm','quasi-newton','SpecifyObjectiveGradient',true);

for i=2:M
     F=@(x) minmovf(x,reshape(u(i-1,:),[n,n]),DX,DXX,DXXXX,delta,epsilon,n,tres);
     u(i,:) = reshape(fminunc(F,guess,options),[n^2,1]);
     disp([i,norm((u(i-1,:)-u(i,:))),functional2d(reshape(u(i,:),[n,n]),DX,DXX,delta,epsilon)]);
     surf(reshape(u(i,:),[n,n]));
     zlim([0,0.8])
     pause(0.1)
     %tres = 3*tres;
end

%save(strcat('./data/e',num2str(epsilon),'d',num2str(delta),'n',num2str(n),'m',num2str(M),'t',num2str(T),'.mat'),'u','tres','x','y','M','T','n','epsilon','delta');





