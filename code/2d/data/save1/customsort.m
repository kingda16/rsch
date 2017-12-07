function [ assignments ] = customsort(X,sugg,k )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n = sqrt(length(X));
X = [sugg; X];
full = kmeans(X,k+1);
scatter(X(:,1),X(:,2))
idx = reshape(full(k+1:end,:),[n,n]);
assignments = zeros(n,n);
for i=1:k
   bool = (idx -full(i))==0;
   assignments = assignments + i*bool; 
end



end

