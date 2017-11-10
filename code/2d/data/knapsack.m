function [mid,out] = knapsack( w,v,W )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
if W == 0
    mid = [];
    out = 0;
    return
end
n = length(w);
if n == 0
    out = 0;
    mid = [];
    return
end
K = zeros(1,W);
backtrack = linspace(1,W,W);

for x =1:W
    if w(1) <= x
        K(x) = v(1);
    else
        K(x) = 0;
    end
end

for y = 2:n
   if y > floor(n/2)
       for x = W:-1:1
           if w(y) == x
               if v(y) > K(x)
                   backtrack(x) = 0;
               end
           end
           if w(y) < x
               if K(x) < K(x-w(y))+v(y)
                   backtrack(x) = backtrack(x-w(y));
               end
           end
       end
   end
   for x = W:-1:1
       if w(y) == x
           K(x) = max([v(y),K(x)]);
       end
       if w(y) < x
           if K(x) <= K(x-w(y))+v(y)
               K(x) = K(x-w(y))+v(y);
           end
       end
   end
end

out = K(W);
mid = backtrack(W);

end

