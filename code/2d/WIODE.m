function [udot] = WIODE(t,u,D,DXX,DYY,N)


u=reshape(u,[N,N]);

udot=(DXX*u')'+DYY*u+u-u.^3;

%% Dirichlet Conditions on Left
udot(:,1)=0;

%% Dirichlet Conditions on Right
udot(:,end)=0;

%% Dirichlet Conditions on Top
udot(end,:)=0;

%% Dirichlet Conditions on Bottom
udot(1,:)=0;



udot=reshape(udot,[N*N,1]);

end

