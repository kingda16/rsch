function [energy,udot] = dmingrad2d(t,u,DX,DXX,DXXXX,DY,DYY,DYYYY,cleanup,delta,epsilon,N)


%dmin for direct minimization


ux = DX*u;
uxx = DXX*u;
uxxxx = DXXXX*u;
uy = DY*u;
uyy = DYY*u;
uyyyy = DYYYY*u;
uxy = DX*uy;
uxxyy = DXX*uyy;

udot = 2*delta*u-4*(ux.*(2*uxx+2*uxy)+uy.*(2*uyy+2*uxy)+(uxx+uyy).*(ux.^2+uy.^2-1))+2*epsilon.^2*(uxxxx+uyyyy+2*uxxyy);


udot = reshape(udot,[N,N]);
udot = udot(:,2:end-1);
udot = udot(2:end-1,:);
udot = reshape(udot,[(N-2)^2,1]);



energy = functional2d(u,DX,DXX,DY,DYY,cleanup,delta,epsilon,N);



end