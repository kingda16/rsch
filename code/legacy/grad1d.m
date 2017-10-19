function [var] = functional(delta,epsilon,guess,DX,dx)



y=[0,guess,0];
yd = DX*y';
y2d = DX*DX*y';
total = delta*y.^2+((yd').^2-1).^2+epsilon^2*(y2d').^2;
total(1) = total(1)/2;
total(end) = total(end)/2;
F = sum(total)*dx;



end
