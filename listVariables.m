% listVariables.

% Read file.
fileName = 'debrecen.csv';
dataM = csvread(fileName);
timeVec = [1:744]'*3600;

% Convection.
convCoeffExt = 20;
convCoeffIn = 20;
outT = [timeVec, dataM(:,1)+273.15];
radHeat = [timeVec, 3600*dataM(:,2)];

% Operation variables.
Tset = 295.15;
Qbase = 10000;
Qutil = 75;

% Wall.
thickness = 0.2;
densityWall = 1400;
specificHeatW = 1000; % J/kgK
areaWall = 85;

% Window.
areaWin = 0.3*areaWall;
trans = 0.861;

% Air.
densityAir = 1.225;
specificHeatA = 718; % J/kgK
volumeAir = 75;

h = 5;
k = 0.51;
delta = 0.2;
rhoW = 1400;
cpW = 1000;
Awall = 85;
trans = 0.861;
Awin = 0.3*Awall;
Vair = 75;
Qpeople = 75;
Qb = 20;
Tref = 295.15;


cons1 = 1.0/(rhoW*cpW*0.5*delta);
cons2 = 1.0/(rhoW*cpW*Vair);

A = [-(h+k/delta)*cons1 k/delta*cons1 0 0;
     k/delta*cons1 -2*k/delta*cons1 k/delta*cons1 0;
     0 k/delta*cons1 -(h+k/delta)*cons1 h*cons1;
     0 0 h*Awall*cons2 (-h*Awall)*cons2];
 B = [1 0 0; 0 0 0; 0 0 0; 0 1 1];
 outT2 = [dataM(:,1)+273.15];
 radHeat2 = [3600*dataM(:,2)];
 u1 = [timeVec, (radHeat2 + h*outT2)*cons1];
 u4 = [timeVec, (trans*Awin*radHeat2 + Qpeople)*cons2];

