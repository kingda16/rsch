function [udot] = grad1d(t,u,DX,DXX,delta,epsilon)
%u = sparse(u);
ux = (DX*u);
uxx = DXX*ux;
ux4 = DXX*uxx;

udot=2*delta*u+4*uxx.*(1-ux.^2-2.*ux)+2*epsilon^2*ux4;
udot(1)=0;
udot(end)=0;




end

