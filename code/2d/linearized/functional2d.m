function [total] = functional2d(u,DX,DXX,DY,DYY,cleanup,delta,epsilon,N)

ux = DX*u;
uxx = DXX*u;
uy = DY*u;
uyy = DYY*u;
uxy = DX*uy;
uxxyy = DXX*uyy;



total = delta*u.^2+(ux.^2+uy.^2-1).^2+epsilon.^2*(uxx.^2+uyy.^2+uxy.^2);
total(1,:) = total(1,:)/2;
total(end,:) = total(end,:)/2;
total(:,end) = total(:,end)/2;
total(:,1) = total(:,1)/2;


total = sum(sum(total));


end
