data = []

for i=1:M
    data = [data functional2d(delta,epsilon,u(i,:),DX,DXX,dx,n)];
end