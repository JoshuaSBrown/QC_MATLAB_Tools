function Tranfer_Intg(MonA,MonB,Dimer)
%Function takes 6 files two files for each MonomerA, MonomerB and Dimer
%where the files are .log and .pun

if(strcmp('.',MonA(end-3))~=1)
    file_core = MonA(1:end-3);
    MonA_pun = strcat(file_core,'.pun');
    MonA_log = strcat(file_core,'.log');
else
    MonA_pun = strcat(MonA,'.pun');
    MonA_log = strcat(MonA,'.log');
end

if(strcmp('.',MonB(end-3))~=1)
    file_core = MonB(1:end-3);
    MonB_pun = strcat(file_core,'.pun');
    MonB_log = strcat(file_core,'.log');
else
    MonB_pun = strcat(MonB,'.pun');
    MonB_log = strcat(MonB,'.log');
end

if(strcmp('.',Dimer(end-3))~=1)
    file_core = Dimer(1:end-3);
    Dimer_pun = strcat(file_core,'.pun');
    Dimer_log = strcat(file_core,'.log');
else
    Dimer_pun = strcat(Dimer,'.pun');
    Dimer_log = strcat(Dimer,'.log');
end

%Identify Atoms that are in the monomer but not in the dimer
AtomsA = Load_Coord(MonA_log);
AtomsB = Load_Coord(MonB_log);
AtomsD = Load_Coord(Dimer_log);

Num_AtomsA = length(AtomsA);
Num_AtomsB = length(AtomsB);
Num_AtomsD = length(AtomsD);

%Create an array that tracks the atoms that appear both in the
%dimer and the monomer
Atoms_repA = zeros(NumAtomsA,1);
Atoms_repB = zeros(NumAtomsB,1);
Atoms_repD = zeros(NumAtomsD,1);

%Cycle Atoms and determine which ones have the same positions
for i=1:Num_AtomsA
    
    xA = AtomsA(i,4);
    yA = AtomsA(i,5);
    zA = AtomsA(i,6);
    
    for j=1:Num_AtomsD
        
        xD = AtomsD(j,4);
        yD = AtomsD(j,5);
        zD = AtomsD(j,6);
        
        if(xA==xD && yA==yD && zA==zD)
           Atoms_repA(i)=1;
           Atoms_repD(j)=1;
        end
    end
end

for i=1:Num_AtomsB
    
    xB = AtomsB(i,4);
    yB = AtomsB(i,5);
    zB = AtomsB(i,6);
    
    for j=1:Num_AtomsD
        
        xD = AtomsD(j,4);
        yD = AtomsD(j,5);
        zD = AtomsD(j,6);
        
        if(xB==xD && yB==yD && zB==zD)
           Atoms_repB(i)=1;
           Atoms_repD(j)=1;
        end
    end
end

end