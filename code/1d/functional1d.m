function [F] = functional1d(delta,epsilon,u,DX,DXX,dx)


ux = DX*u;
uxx = DXX*u;
total = ((ux).^2-1).^2+delta*u.^2+epsilon^2*(uxx).^2;
total(1) = total(1)/2;
total(end) = total(end)/2;
F = sum(total)*dx;



end
