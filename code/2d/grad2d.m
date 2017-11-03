function [udot] = grad2d(t,u,DX,DXX,DXXXX,delta,epsilon,N)


u=reshape(u,[N,N]);

ux = DX*u;
uxx = DXX*u;
uxxxx = DXXXX*u;
uy = (DX*u')';
uyy = (DXX*u')';
uyyyy = (DXXXX*u')';
uxy = DX*uy;
uxxyy = DXX*uyy;

udot = -(2*delta*u-4*(ux.*(2*uxx+2*uxy)+uy.*(2*uyy+2*uxy)+(uxx+uyy).*(ux.^2+uy.^2-1))+2*epsilon.^2*(uxxxx+uyyyy+2*uxxyy));

udot(1,:) = 0;
udot(end,:) = 0;
udot(:,1) = 0;
udot(:,end) = 0;


udot=reshape(udot,[N*N,1]);
end

