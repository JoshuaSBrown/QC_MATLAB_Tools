function PlotUV_VisSpectra( FileName )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
close all
fclose all
fid = fopen(FileName);

fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);

C = textscan(fid,'%f %f %f');

Wavelength = C{1};
Epsilon = C{2};
OscillatorStrength = C{3};

figure()
plot(Wavelength,Epsilon,'LineWidth',2)
set(gcf,'Color','w');
xlabel('Excitation Energy [nm]');
ylabel('Epsilon')

end

