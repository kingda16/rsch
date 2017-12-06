function [ f,grad ] = minmovf(u,old,DX,DXX,DXXXX,delta,epsilon,n,T)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


f = functional2d(u,DX,DXX,delta,epsilon)+(1/(2*T))*norm(old-u)^2;
grad=reshape(-grad2d(0,reshape(u,[n^2,1]),DX,DXX,DXXXX,delta,epsilon,n),[n,n])+2*(u-old);
end

