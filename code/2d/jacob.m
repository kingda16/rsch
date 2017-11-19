function [ J ] = jacob(u,DX,DXX,DXXXX,DY,DYY,DYYYY,cleanup,delta,epsilon,N)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

ux = DX*u;
uxx = DXX*u;
uxxxx = DXXXX*u;
uy = DY*u;
uyy = DYY*u;
uyyyy = DYYYY*u;
uxy = DX*uy;
uxxyy = DXX*uyy;

J = -(2*delta*eye(N^2)+2*epsilon^2*(DXXXX+DYYYY+2*DXXYY)-4(2*(DX*uxx+DXX*ux+DX*uxy+DX*DY*ux)+2*(DY*uyy));

%figure out what's going on with matrix powers
-(2*delta*u-4*(ux.*(2*uxx+2*uxy)+uy.*(2*uyy+2*uxy)+(uxx+uyy).*(ux.^2+uy.^2-1))+2*epsilon.^2*(uxxxx+uyyyy+2*uxxyy));

J(1:N) = 0;
J(end-N+1:end) = 0;
J.*cleanup;





end

