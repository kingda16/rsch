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
guess = zeros(n,n);


%identity ui-1+ui+1==2ui at bdry


DXt=(-1*diag(ones(1,n-1),-1)+1*diag(ones(1,n-1),1));
DXt(1,1) = -2;
DXt(1,2) = 2;
DXt(end,end) = 2;
DXt(end,end-1) = -2;


DXXt=(1*diag(ones(1,n-1),-1)+1*diag(ones(1,n-1),1)-2*diag(ones(1,n)));
DXXt(1,1) = 0;
DXXt(1,2) = 0;
DXXt(end,end) = 0;
DXXt(end,end-1) = 0;

DXXXXt=(1*diag(ones(1,n-2),-2)+1*diag(ones(1,n-2),2)-4*diag(ones(1,n-1),-1)-4*diag(ones(1,n-1),1)+6*diag(ones(1,n)));
DXXXXt(1,1) = -5;
DXXXXt(1,2) = 14;
DXXXXt(1,3) = -14;
DXXXXt(1,4) = 6;
DXXXXt(1,5) = -1;

DXXXXt(end,end) = -5;
DXXXXt(end,end-1) = 14;
DXXXXt(end,end-2) = -14;
DXXXXt(end,end-3) = 6;
DXXXXt(end,end-4) = -1;

DXXXXt(2,1) = -2;
DXXXXt(2,2) = 5;
DXXXXt(2,3) = -4;
DXXXXt(2,4) = 1;

DXXXXt(end-1,end) = -2;
DXXXXt(end-1,end-1) = 5;
DXXXXt(end-1,end-2) = -4;
DXXXXt(end-1,end-3) = 1;


DXt=1/(2*dx)*DXt;
DXXt = 1/(dx^2)*DXXt;
DXXXXt=1/(dx^4)*DXXXXt;

DXXXXt = sparse(DXXXXt);
DXXt = sparse(DXXt);
DXt = sparse(DXt);

%we need big-boy differential operators
%these eliminate the need for all this reshaping

DY = mat2cell(repmat(DXt,1,n),n,repmat(n,1,n));
DY = blkdiag(DY{:});

DX = sparse(n,n);
for i=1:n
    for j=1:n
        DX((i-1)*n+1:i*n,(j-1)*n+1:j*n) = DXt(i,j)*eye(n);
    end
end


DYY = mat2cell(repmat(DXXt,1,n),n,repmat(n,1,n));
DYY = blkdiag(DYY{:});

DXX = sparse(n,n);
for i=1:n
    for j=1:n
        DXX((i-1)*n+1:i*n,(j-1)*n+1:j*n) = DXXt(i,j)*eye(n);
    end
end


DYYYY = mat2cell(repmat(DXXXXt,1,n),n,repmat(n,1,n));
DYYYY = blkdiag(DYYYY{:});

DXXXX = sparse(n,n);
for i=1:n
    for j=1:n
        DXXXX((i-1)*n+1:i*n,(j-1)*n+1:j*n) = DXXXXt(i,j)*eye(n);
    end
end


cleanup = [0; ones(n-2,1); 0];
cleanup = repmat(cleanup,n,1);


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

guess = sin(pi*x)+sin(pi*y);


%guess = 0.25*sin(7*pi*x).*sin(7*pi*y);

guess(1,:) = 0; 
guess(end,:) = 0;
guess(:,1) = 0;
guess(:,end) = 0;

guess=reshape(guess,[n*n,1]);

J =@(t,u,Flag)jacob(u,DX,DXX,DXXXX,DY,DYY,DYYYY,cleanup,delta,epsilon,n);

options = odeset('Stats','on','Jacobian',J);
[t,u] = ode23s(@(t,u) grad2d(t,u,DX,DXX,DXXXX,DY,DYY,DYYYY,cleanup,delta,epsilon,n),t,guess,options);

save(strcat('./data/e',num2str(epsilon),'d',num2str(delta),'n',num2str(n),'m',num2str(M),'t',num2str(T),'.mat'),'u','t','x','y','M','T','n','epsilon','delta');

end

