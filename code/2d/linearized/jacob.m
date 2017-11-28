function [ J ] = jacob(u,DX,DXX,DXXXX,DY,DYY,DYYYY,cleanup,delta,epsilon,N)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

ux = DX*u;
uxx = DXX*u;
uy = DY*u;
uyy = DYY*u;
uxy = DX*uy;


DXY = DX*DY;

J = -(2*delta*speye(N^2)+2*epsilon^2*(DXXXX+DYYYY+2*DXX*DYY));

for i=1:N
   DX(:,i) = DX(:,i).*(uxx+uxy+uxx.*ux+uyy.*ux);
   DY(:,i) = DY(:,i).*(uyy+uxy+uxx.*uy+uyy.*uy);
   DXX(:,i) = DXX(:,i).*(2*ux-1+ux.^2+uy.^2);
   DYY(:,i) = DYY(:,i).*(2*uy-1+ux.^2+uy.^2);
   DXY(:,i) = DXY(:,i).*(ux+uy);
end


J = J+4*(2*DXY+DXX+DYY+2*DX+2*DY);



J(1:N) = 0;
J(end-N+1:end) = 0;


for i=1:N
    J(:,i) = J(:,i).*cleanup;
end






end

