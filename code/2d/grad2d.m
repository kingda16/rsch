function [udot] = grad2d(t,u,DX,DXX,DXXXX,delta,epsilon,N)


u = reshape(u,[N,N]);
ux = u*DX';
uxx = u*DXX';
uxxxx = u*DXXXX';
uy = DX*u;
uyy = DXX*u;
uyyyy = DXXXX*u;
uxy = uy*DX';
uxxyy = uyy*DXX';

udot = -(2*delta*u-4*(ux.*(2*ux.*uxx+2*uy.*uxy)+uy.*(2*uy.*uyy+2*ux.*uxy)+(uxx+uyy).*(ux.^2+uy.^2-1))+2*epsilon.^2*(uxxxx+uyyyy+2*uxxyy));




udot(:,end) = 0;
udot(:,1) = 0; 
udot(end,:) = 0;
udot(1,:) = 0; 
udot = reshape(udot,[N^2,1]);



end

