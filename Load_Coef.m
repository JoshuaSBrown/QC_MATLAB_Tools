function [ Coef ] = Load_Coef( filename )
%This function is designed to parse a .pun file from a gaussian run. To
%output this file use the keyword iop(3/33=1) in the gaussian run. This
%will output a fort.7 file which can be relabeled with the .pun extension
%and then read in using this function

fclose all;
close all

%Determine if the file has .log file extension
if(strcmp('.pun',filename(end-3:end))~=1)
    error('Error file is not of type *.pun');
end

fid = fopen(filename,'r');

%Determine the number of Molecular orbitals (MOs)
MOs = 0;
line = fgetl(fid);
while(~feof(fid))
    if(~isempty(strfind(line,'Alpha MO OE=')))
        MOs = MOs + 1;
    end
    line = fgetl(fid);
end

%Create a coefficient matrix
Coef = ones(MOs);

%Column of Overlap matrix
jj = 1;
rows = ceil(MOs/5);

%Rewind file identifier to front of file
frewind(fid);
%Skip first line
fgetl(fid);
while(jj<=MOs)
    %Skip first line
    fgetl(fid);
    ii = 1;
    %Cycle basis rows
    for i=1:rows
        line = fgetl(fid);
        %Cycle columns
        if((MOs-ii+1)<5)
            cols = MOs-ii+1;
        else
            cols = 5;
        end
        
        for j=0:(cols-1)
            value = line(1:15);
            value = strrep(value,'D','E');
            Coef(jj,ii) = str2double(value);
            line = line(16:end);
            ii = ii+1;
        end
        
    end
    %Increment the column in the Overlap matrix
    jj = jj + 1;
    
end

fclose(fid);
end

