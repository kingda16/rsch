function [F] = functional1d(delta,epsilon,guess,DX,dx)


y=guess;
yd = DX*y';
y2d = DX*DX*y';
%((yd').^2-1).^2+
%delta*y.^2+
%epsilon^2*(y2d').^2;
total = ((yd').^2-1).^2;
total(1) = total(1)/2;
total(end) = total(end)/2;
F = sum(total)*dx;



end
