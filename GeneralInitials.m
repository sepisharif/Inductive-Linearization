%% General Initials
dose = 3;
y0=[dose 0];

%% The fixed step size 
stepsize=0.01;
T=[0.1 0.25 0.5 0.75 1 2 4 6 8 12 16 24 30];
minTime=0;
maxTime=max(T);

%% The fixed N
maxLin=20; 

%% limitations
BreakFlag=0;
tolRelEf =1e-6;