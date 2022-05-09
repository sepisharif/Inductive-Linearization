% Parameter values
ka=1; 
v=1;
vmax=0.2; 
km=0.5; 

%% Standard deviation of the residual variability
sigma=0.1;

%% Variance of the between subject effects
OMEGA=zeros(4,4);

 OMEGA=[0.316 0 0 0 
     0 0.316 0 0
     0 0 0.316 0
     0 0 0 0.316];

