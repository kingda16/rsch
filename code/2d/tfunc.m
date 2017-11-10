function [ z ] = tfunc(x,y)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
if x < 0.5
    z = x;
else
    z = 1-x;
end

if y < 0.3-3/5*abs(0.5-x)
    z = 5/3*y;
end
    
if y > 0.7+0.6*abs(0.5-x)
    z = 0.7-y;
end

end

