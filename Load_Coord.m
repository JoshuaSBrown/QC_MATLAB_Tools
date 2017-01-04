function [ Atoms ] = Load_Coord( filename )
%This function is designed to parse a .log file from a gaussian run and
%find the coordinates

fclose all
close all

%Determine if the file has .log file extension
if(strcmp('.log',filename(end-3:end))~=1)
    error('Error file is not of type *.log');
end

fid = fopen(filename,'r');

line = fgetl(fid);
while(isempty(strfind(line,' Input orientation:')))
   line = fgetl(fid); 
end

%skip next 3 lines
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);
line = fgetl(fid);

Atoms = ones(1,6);
i = 1;

while(isempty(strfind(line,'-------------------')))
   
    if(i==1)
       Atoms = str2num(line); 
       i = 2;
    else
       Atoms = [Atoms ; str2num(line)];
    end
    line = fgetl(fid);
end
fclose(fid);
end


