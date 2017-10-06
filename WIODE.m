function [udot] = WIODE(delta,epsilon,u,DX,dx)


n = sqrt(length(u));
u = reshape(u,[n,n]);

n = length(u);
disp(n)
disp(size(u))
u = [zeros(1,n+2); zeros(n,1) u zeros(n,1); zeros(1,n+2)];


ux = (DX*u')';
uy = (DX*u)';
uxx = (DX*ux')';
uyy = (DX*uy)';
uyx = (DX*uy')';
uxxx = (DX*uxx')';
uyxx = (DX*uxx)';
uxxxx = (DX*uxxx')';
uyyxx = (DX*uyxx)';
uyyy = (DX*uyy)';
uxyy = (DX*uyy')';
uyyyy = (DX*uyyy)';
uxxyy = (DX*uxyy')';



total = delta*u*2+4*(uxx.^2+uyy.^2-1).*(uxx+uyy)+2*epsilon^2*(ux.*(uxxxx+uyyyy)+uy.*(uxxyy+uyyyy));
total = total(2:end-1,2:end-1);

udot = total*dx^2;
udot=reshape(udot,[n*n,1]);
disp(udot)


end

