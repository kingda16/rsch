function [ seq ] = sequencer( w,v,W )
%The workhorse. Sequences the path along the ghost table over items with
%weights/values w/v and max capacity W.
%recursive


n = length(w);
%if there is no room left, the 'sequence' is jsut 0's
if W == 0
    seq = zeros(1,n-1);
    return
end
%and in the base case, there are no subproblems left to solve
if n==1
    seq = [];
    return
end
%find the midpoint
k = knapsack(w,v,W);
%if the problem was big enough, solve the subproblems produced on either
%side
if n > 2
    k2 = sequencer(w(ceil(n/2)+1:n),v(ceil(n/2)+1:n),W-k);
    k1 = sequencer(w(1:ceil(n/2)),v(1:ceil(n/2)),k);
else
    %otherwise, don't - they are moot problems
    k2 = [];
    k1 = [];
end
%offset the right subproblem by the midpoint
k2 = k2+k;
%and concatenate to return the sequences.
seq =  [k1 k k2];

end

