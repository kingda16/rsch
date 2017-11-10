% vidObj = VideoWriter('test.avi');
% open(vidObj);
% 
% figure('units','normalized','outerposition',[0 0 1 1]);
% 
% for k=1:M,
%         clf;
%     out = reshape(u(k,:),[n,n]);
%     %contourf(out,200,'Linestyle','none')
% 
%     surf(x,y,out);
%     view(-37.5,30);
% shg;
% zlim([-1 1])
%     currFrame = getframe(gcf);
%     writeVideo(vidObj,currFrame);
%     
% end
% 
% close(vidObj);


surf(out)
