function [F] = functional2d(delta,epsilon,u,DX,DXX,dx,N)
u=reshape(u,[N,N]);

ux = DX*u;
uxx = DXX*u
uy = (DX*u')';
uyy = (DXX*u')';
uxy = (DX*(DX*u)')';

total = delta*u.^2+(ux.^2+uy.^2-1).^2+epsilon.^2*(uxx.^2+uyy.^2+uxy.^2);
total(1,:) = total(1,:)/2;
total(end,:) = total(end,:)/2;
total(:,end) = total(:,end)/2;
total(:,1) = total(:,1)/2;

F = sum(sum(total));


end
