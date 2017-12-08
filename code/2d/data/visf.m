function [etot] = visf(u,DX,DXX,delta,epsilon,x,y,epast)


% surf
% quivered
% energy
% localized energy


n = length(u);
ux = u*DX';
uy = DX*u;
plane = (1-ux.^2-uy.^2).^2<0.5;
uxx = u*DXX';
uyy = DXX*u;
uxy = uy*DX';

total = delta*u.^2+(ux.^2+uy.^2-1).^2+epsilon.^2*(uxx.^2+uyy.^2+uxy.^2);
total(1,:) = total(1,:)/2;
total(end,:) = total(end,:)/2;
total(:,end) = total(:,end)/2;
total(:,1) = total(:,1)/2;

subplot(2,2,1)
surf(x,y,u);
xlabel('x')
ylabel('y')


a1=subplot(2,2,2);
pcolor(abs(atan2(uy,ux)));
alpha 0.5
shading flat
set(a1,'color','none')
set(a1,'xtick',[],'ytick',[]);
xlabel('x')
ylabel('y')
a2 = axes('Position',get(a1,'Position'))
axes(a2)
q=quiver(x(1:3:end),y(1:3:end),0.03*ux(1:3:end).*plane(1:3:end),0.03*uy(1:3:end).*plane(1:3:end));
q.Color = 'black';
q.AutoScale = 'off';
axis tight
set(a2,'color','none')


subplot(2,2,3)
surf(x,y,total)
xlabel('x')
ylabel('y')
zlim([0,10]);

subplot(2,2,4)
etot = [epast sum(sum(total))/n^2];
plot(log10(etot))






%contourf(out,200,'Linestyle','none')
%contourf((1-sqrt((DX*out).^2+((DX*(out')).^2)')).^2,linspace(-0.2,0.2,100),'LineStyle','none');
%scatter(reshape(xd.*plane,[n^2,1]),reshape(yd.*plane,[n^2,1]))

end
