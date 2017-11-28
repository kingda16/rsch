function [] = gflow2d( delta,epsilon,n,M,T,offset)
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
%for i = 1:n
%    for j = 1:n
%        guess(i,j) = max([0.2*power(10*x(1,i).*(1-x(1,i)).*(1-y(j,1)).*y(j,1),1/4),min([min([1-x(1,i),1-y(j,1),x(1,i)]),1-max([1-x(1,i),1+offset-y(j,1),x(1,i)])])]);
%    end
%end


%for i = 1:n
%for j = 1:n
%guess(i,j) = max([0.2*power(10*x(1,i).*(1-x(1,i)).*(1-y(j,1)).*y(j,1),1/4),min([1-x(1,i),x(1,i),y(j,1),1-y(j,1)])]);
%end
%end


% for i = 1:n
%     for j = 1:floor(n/2)
%         guess(i,j) = min([x(1,j),0.5-x(1,j),y(i,1),1-y(i,1)]);
%     end
% end
% for i = 1:n
%     for j = floor(n/2)+1:n
%         guess(i,j) = min(abs([y(i,1)-0.5,0.5-y(i,1),x(1,j)-0.5,1-x(1,j),2*y(i,1),2-2*y(i,1)]));
%     end
% end
% 
% for i =1:n
%     for j = 1:n
%         guess(i,j) = max([0.4*power(10*x(1,j).*(1-x(1,j)).*(1-y(i,1)).*y(i,1),1/4),guess(i,j)]);
%     end
% end

guess = sin(pi*x).*sin(pi*y);


%guess = 0.25*sin(7*pi*x).*sin(7*pi*y);

guess(1,:) = 0; 
guess(end,:) = 0;
guess(:,1) = 0;
guess(:,end) = 0;

guess=reshape(guess,[n*n,1]);
grad2d(0,guess,DX,DXX,DXXXX,delta,epsilon,n);

options = odeset('Stats','on');
[t,u] = ode45(@(t,u,f) grad2d(t,u,DX,DXX,DXXXX,delta,epsilon,n),t,guess,[],options);

save(strcat('./data/e',num2str(epsilon),'d',num2str(delta),'n',num2str(n),'m',num2str(M),'t',num2str(T),'.mat'),'u','t','x','y','M','T','n','epsilon','delta');
surf(reshape(u(end,:),[n,n]))
end

