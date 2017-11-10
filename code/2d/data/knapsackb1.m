file = fileread('ktest.txt');
file = strsplit(file);
W = str2num(file{2});
n = str2num(file{4});
w = zeros(1,n);
v = zeros(1,n);
for i=1:n
    w(i) = str2num(file{2+4*i});
    v(i) = str2num(file{4+4*i});
end


knapsack(w,v,W)