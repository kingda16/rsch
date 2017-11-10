function [mid,out] = knapsack( w,v,W )
%The core function. Solves the knapsack problem with weight/values w and v
% and max capacity W. Returns both optimum value and the value after the
% first n/2 items, as suggested

%intialize variables, including a 'backtrack' array for finding the midpoint
%value
n = length(w);
K = zeros(1,W);
backtrack = linspace(1,W,W);

%seed the vertical slice of the table, as before
for x =1:W
    if w(1) <= x
        K(x) = v(1);
    else
        K(x) = 0;
    end
end

%and fill it in as before
for y = 2:n
   %except this time, if we are past halfway we also update the backtrack
   %array that is keeping track of where our optimum path was at the
   %midpoint, hanzel and gretel style. Basically runs on 'argmax'
   if y > ceil(n/2)
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
   %and the standard table filling-in
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

%spits out necessary values
out = K(W);
mid = backtrack(W);

end

