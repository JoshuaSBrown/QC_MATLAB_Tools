function [ S ] = Load_Overlap( filename )
%This function is designed to parse a .log file from a gaussian run and
%find the overlap matrix it will then load it into a matrix and return it.
%   Detailed explanation goes here

fclose all
close all

%Determine if the file has .log file extension
if(strcmp('.log',filename(end-3:end))~=1)
    error('Error file is not of type *.log');
end

fid = fopen(filename,'r');

%Determine the size of the basis set
line = fgetl(fid);
while(isempty(strfind(line,'NBasis = ')))
    line = fgetl(fid);
end

line = line(13:end);
indx = strfind(line,'MinDer');
line = line(1:indx-1);
line = strtrim(line);

NBasis = str2num(line);

%Find the overlap matrix
while(isempty(strfind(line,' *** Overlap ***')))
   line = fgetl(fid); 
end

%Generate Matrix
S = ones(NBasis);
%Column of Overlap matrix
jj = 1;
start = 1;

rows = NBasis;
while(jj<=NBasis)
    %Skip first line
    fgetl(fid);
    cols = 1;
    ii = start;
    
    %Cycle basis rows
    for i=1:rows
        line = fgetl(fid);
        line = line(9:end);
        %Cycle columns
        for j=0:(cols-1)
            value = line(1:13);
            S(ii,jj+j) = str2num(value);
            S(jj+j,ii) = str2num(value);
            line = line(15:end);
        end
        if(cols<5)
            cols = cols+1;
        end
        
        %Increment ii
        ii = ii + 1;
    end
    %Increment the column in the Overlap matrix
    jj = jj + 5;
    start = start + 5;
    rows = rows-5;
end
fclose(fid);
end


