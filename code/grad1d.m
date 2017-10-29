function [udot] = grad1d(t,u,DX,DXX,DXXXX,delta,epsilon)
%u = sparse(u);
ux = DX*u;
uxx = DXX*u;
uxxxx = DXXXX*u;
udot=-(2*delta*u-4*(3*uxx.*ux-uxx)+2*epsilon^2*uxxxx);
udot(1)=0;
udot(end)=0;




end

