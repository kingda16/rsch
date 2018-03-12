function [udot] = grad2d(t,u,DX,DXX,DXXXX,delta,epsilon,N,f,g)


u = reshape(u,[N,N]);
ux = u*DX';
uxx = u*DXX';
uxxxx = u*DXXXX';
uy = DX*u;
uyy = DXX*u;
uyyyy = DXXXX*u;
uxy = uy*DX';
uxxyy = uyy*DXX';
fx = f*DX';
gy = DX*g;

udot = -(2*delta*u-4*(3*ux.^2.*uxx-uxx.*f-fx.*ux+3*uy.^2.*uyy-uyy.*g-gy.*uy)+2*epsilon.^2*(uxxxx+uyyyy+2*uxxyy));


udot(:,end) = 0;
udot(:,1) = 0; 
udot(end,:) = 0;
udot(1,:) = 0; 
udot = reshape(udot,[N^2,1]);



end

