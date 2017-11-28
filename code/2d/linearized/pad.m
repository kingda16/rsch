function [ padded ] = pad(x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = sqrt(length(x));
x = reshape(x,[n,n]);
padded = [zeros(1,n+2);zeros(n,1) x zeros(n,1); zeros(1,n+2)];
padded = reshape(padded,[(n+2)^2,1]);

end

