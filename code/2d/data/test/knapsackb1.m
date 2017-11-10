%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% Dylan King
% CSC 222 FA 2017
% Dr. Ballard
%
% I gave up on python and returned to matlab for convenient one-indexing. I
% am sorry.
%
% This code is order Wn in time and W in space. To run it, have the file in
% 'fileread' in the same folder, and it will write output to 'outfile'.
% Also make sure that the companion functions 'knapasck' and 'sequencer'
% are in the same folder.
% For an algorithmic description see the attached pdf.
% this file, while labeled b1, solves both b2 and b1 since b1 is contained
% within b2 as a problem.


%this block reads in/parses the data
file = fileread('small.txt');
file = strsplit(file);
W = str2num(file{2});
n = str2num(file{4});
w = zeros(1,n);
v = zeros(1,n);
for i=1:n
    w(i) = str2num(file{2+4*i});
    v(i) = str2num(file{4+4*i});
end

%pulls in the 'sequence' of weights associated with each item, effectively
%finding the path across the graph (work here is done is subfunction)
seq = [sequencer(w,v,W) W];
%also stores the optimum value
[~,V] = knapsack( w,v,W );
%intializes an aray to keep track of item inclusion
included = zeros(1,n);
for i=2:n
    %the path across the 'ghost table' will either drop if an item is
    %included or remain constant if it was not
    if seq(i-1) ~= seq(i)
        included(i) = 1;
    end
end

%handle the first item separately because it was annoying to program
%conditionally; it doesn't come out of 'sequence', just relate to the first
%element in the list
if  w(1) <= seq(1)
    included(1) = 1;
end

%write the resulting data to a file
outfile = 'small-output-b.txt';
dlmwrite(outfile,['V ',int2str(V)],'-append','delimiter','');
dlmwrite(outfile,['i ',int2str(sum(included))],'-append','delimiter','');
for i=1:n
    if included(i) == 1
        dlmwrite(outfile,int2str(i),'-append','delimiter','');
    end
end
        

