function [ seed ] = seedgen(n,name,k,l)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

x=linspace(0,1,n);
[x,y] = meshgrid(x,x);
seed = x;

if all(name == 'trig')
    seed = sin(pi*k*x).*sin(pi*l*y);
end
% %% Construction of initial profile
% %for i = 1:n
% %    for j = 1:n
% %        guess(i,j) = max([0.2*power(10*x(1,i).*(1-x(1,i)).*(1-y(j,1)).*y(j,1),1/4),min([min([1-x(1,i),1-y(j,1),x(1,i)]),1-max([1-x(1,i),1+offset-y(j,1),x(1,i)])])]);
% %    end
% %end
% 
% % 
% for i = 1:n
% for j = 1:n
% seed(i,j) = max([0.2*power(10*x(1,i).*(1-x(1,i)).*(1-y(j,1)).*y(j,1),1/4),min([1-x(1,i),x(1,i),y(j,1),1-y(j,1)])]);
% end
% end
% 
% 
% for i = 1:n
%    for j = 1:floor(n/2)
%        seed(i,j) = min([x(1,j),0.5-x(1,j),y(i,1),1-y(i,1)]);
%    end
% end
% for i = 1:n
%    for j = floor(n/2)+1:n
%        seed(i,j) = min(abs([y(i,1)-0.5,0.5-y(i,1),x(1,j)-0.5,1-x(1,j),2*y(i,1),2-2*y(i,1)]));
%    end
% end
% 
% 
% 
% % 
% for i =1:n
%     for j = 1:n
%         guess(i,j) = max([0.4*power(10*x(1,j).*(1-x(1,j)).*(1-y(i,1)).*y(i,1),1/4),guess(i,j)]);
%     end
% end
% 
% guess = sin(pi*x).*sin(pi*y);
% 
% 
% %guess = 0.25*sin(7*pi*x).*sin(7*pi*y);
% 
% guess(1,:) = 0; 
% guess(end,:) = 0;
% guess(:,1) = 0;
% guess(:,end) = 0;

end

