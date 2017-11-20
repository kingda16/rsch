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

ux = repmat(ux,1,N^2);
uxx = repmat(uxx,1,N^2);
uxxxx = repmat(uxxxx,1,N^2);
uy = repmat(uy,1,N^2);
uyy = repmat(uyy,1,N^2);
uyyyy = repmat(uyyyy,1,N^2);
uxy = repmat(uxy,1,N^2);
uxxyy = repmat(uxxyy,1,N^2);


J = -(2*delta*eye(N^2)+2*epsilon^2*(DXXXX+DYYYY+2*DXX*DYY)-4*(2*(DX.*uxx+DXX.*ux+DX.*uxy+(DX*DY).*ux)+2*(DY.*uyy+DYY.*uy+DY.*uxy+(DX*DY).*uy)-DXX-DYY+DXX.*ux.^2+2*uxx.*DX.*ux+DXX.*uy.^2+2*uxx.*DY.*uy+DYY.*ux.^2+2*uyy.*DX.*ux+DYY.*uy.^2+2*uyy.*DY.*uy));
%figure out what's going on with matrix powers


J(1:N) = 0;
J(end-N+1:end) = 0;
J = J.*repmat(cleanup,1,N^2);





end

