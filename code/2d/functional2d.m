function [total] = grad2d(u,DX,DXX,DXXXX,DY,DYY,DYYYY,cleanup,delta,epsilon,N)

ux = DX*u;
uxx = DXX*u;
uxxxx = DXXXX*u;
uy = DY*u;
uyy = DYY*u;
uyyyy = DYYYY*u;
uxy = DX*uy;
uxxyy = DXX*uyy;



total = delta*u.^2+(ux.^2+uy.^2-1).^2+epsilon.^2*(uxx.^2+uyy.^2+uxy.^2);
total(1,:) = total(1,:)/2;
total(end,:) = total(end,:)/2;
total(:,end) = total(:,end)/2;
total(:,1) = total(:,1)/2;

total(1:N) = 0;
total(end-N+1:end) = 0; 
total = total.*cleanup;

F = sum(sum(total));


end
