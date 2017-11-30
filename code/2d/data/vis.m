

dx = x(1,2) - x(1,1);
DX=(-1*diag(ones(1,n-1),-1)+1*diag(ones(1,n-1),1));
DX(1,1) = -2;
DX(1,2) = 2;
DX(end,end) = 2;
DX(end,end-1) = -2;


DXX=(1*diag(ones(1,n-1),-1)+1*diag(ones(1,n-1),1)-2*diag(ones(1,n)));
DXX(1,1) = 0;
DXX(1,2) = 0;
DXX(end,end) = 0;
DXX(end,end-1) = 0;

DXXXX=(1*diag(ones(1,n-2),-2)+1*diag(ones(1,n-2),2)-4*diag(ones(1,n-1),-1)-4*diag(ones(1,n-1),1)+6*diag(ones(1,n)));
DXXXX(1,1) = -5;
DXXXX(1,2) = 14;
DXXXX(1,3) = -14;
DXXXX(1,4) = 6;
DXXXX(1,5) = -1;

DXXXX(end,end) = -5;
DXXXX(end,end-1) = 14;
DXXXX(end,end-2) = -14;
DXXXX(end,end-3) = 6;
DXXXX(end,end-4) = -1;

DXXXX(2,1) = -2;
DXXXX(2,2) = 5;
DXXXX(2,3) = -4;
DXXXX(2,4) = 1;

DXXXX(end-1,end) = -2;
DXXXX(end-1,end-1) = 5;
DXXXX(end-1,end-2) = -4;
DXXXX(end-1,end-3) = 1;


DX=1/(2*dx)*DX;
DXX = 1/(dx^2)*DXX;
DXXXX=1/(dx^4)*DXXXX;

DXXXX = sparse(DXXXX);
DXX = sparse(DXX);
DX = sparse(DX);

%vidObj = VideoWriter('test.avi');
%open(vidObj);

figure('units','normalized','outerposition',[0 0 1 1]);

for k=1:3:M,
        clf;
    out = reshape(u(k,:),[n,n]);
    %contourf(out,200,'Linestyle','none')
    %contourf((1-sqrt((DX*out).^2+((DX*(out')).^2)')).^2,linspace(-0.2,0.2,100),'LineStyle','none');
    xd = -out*DX;
    yd = DX*out;
    plane = (1-xd.^2-yd.^2).^2<0.1;
    subplot(1,2,1)
    quiver(x,y,xd.*plane,yd.*plane);
    xlabel('x')
    ylabel('y')
    subplot(1,2,2)
    surf(x,y,out);
    xlabel('x')
    ylabel('y')
    zlim([-1 1])
    %subplot(1,3,3)
    %surf(x,y,reshape(grad2d(t,u(k,:),DX,DXX,DXXXX,delta,epsilon,n),[n,n]))
    %xlabel('x')
    %ylabel('y')
    
    
    %view(-37.5,30);
    %currFrame = getframe(gcf);
    %writeVideo(vidObj,currFrame);
    pause(0.01)
    disp(k)
    
end

%close(vidObj);

