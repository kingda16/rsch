function [F] = functional(delta,epsilon,guess,DX,dx)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
n = length(guess);
u = [zeros(1,n+2); zeros(n,1) guess zeros(n,1); zeros(1,n+2)];

ux = DX*u';
uy = u*DX';
uxx = DX*ux';
uyy = uy*DX';
uyx = DX*uy';

total = delta*u.^2+(uy.^2+ux.^2-1).^2+epsilon^2*(uxx.^2+uyy.^2+2*uyx.^2);
total(:,1) = total(:,1)/2;
total(:,end) = total(:,end)/2;
total(1,:) = total(1,:)/2;
total(end,:) = total(end,:)/2;
F = sum(sum(total))*dx^2;

end

