function [udot] = grad1d(t,u,DX,DXX,delta,epsilon)
%u = sparse(u);
up = (DX*u);
upp = DXX*up;
up4 = DXX*upp;

udot=2*delta*u+4*upp.*(1-up.^2-2.*up)+2*epsilon^2*up4;
udot(1)=0;
udot(end)=0;




end

