function [udot] = grad1d(t,u,DX,delta,epsilon)
u = sparse(u);
up = (DX*u);
upp = (DX*up);
up4 = DX*(DX*upp);

%-2*delta*u-
%4*(upp.*(up.^2-1)+up.*2.*upp.*(up.^2-1))
%2*epsilon^2*up4;
udot=4*upp.*(1-3*up.^2);
udot(1)=0;
udot(end)=0;




end

