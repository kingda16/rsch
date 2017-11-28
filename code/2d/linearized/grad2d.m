function [udot] = grad2d(t,u,DX,DXX,DXXXX,DY,DYY,DYYYY,cleanup,delta,epsilon,N)

ux = DX*u;
uxx = DXX*u;
uxxxx = DXXXX*u;
uy = DY*u;
uyy = DYY*u;
uyyyy = DYYYY*u;
uxy = DX*uy;
uxxyy = DXX*uyy;

udot = -(2*delta*u-4*(ux.*(2*uxx+2*uxy)+uy.*(2*uyy+2*uxy)+(uxx+uyy).*(ux.^2+uy.^2-1))+2*epsilon.^2*(uxxxx+uyyyy+2*uxxyy));

udot(1:N) = 0;
udot(end-N+1:end) = 0; 
udot = udot.*cleanup;


end

