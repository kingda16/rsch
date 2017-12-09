function [total] = functional2d(u,DX,DXX,delta,epsilon)

n = length(u);
ux = u*DX';
uxx = u*DXX';
uy = DX*u;
uyy = DXX*u;
uxy = uy*DX';




total = delta*u.^2+(ux.^2+uy.^2-1).^2+epsilon.^2*(uxx.^2+uyy.^2+uxy.^2);
total(1,:) = total(1,:)/2;
total(end,:) = total(end,:)/2;
total(:,end) = total(:,end)/2;
total(:,1) = total(:,1)/2;


total = sum(sum(total));
total = total/n^2;


end
