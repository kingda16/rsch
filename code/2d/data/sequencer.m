function [ seq ] = sequencer( w,v,W )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
n = length(w);
if n <= 2
    seq = [];
    return
end
k = knapsack(w,v,W);
if n == 3
    seq = [k];
    return
end
k1 = sequencer(w(1:floor(n/2)),v(1:floor(n/2)),k);
k2 = sequencer(w(floor(n/2):n),v(floor(n/2):n),W-k);

seq =  [k1 k k2];


end

