%%  The firts run of IL, for calculating dydt
Getparameters
TimeInitial

for j=1:length(time_init)
    
    CLt=vmax/(km + y0_update_init(j));
    
    %% Define EVD
    k20=-CLt/v;
    
    K=[-ka          0
        ka          k20];
    
    [P_m,Lam_m]=eig(K);
    Pinv=inv(P_m);
    MPart=P_m* (exp(Lam_m.*stepsize).*eye(2)) * Pinv;
    
    if j==1
        y_me_init = MPart*y0';
    else
        y_me_init = MPart*y_me_prev_init;
    end
    
    y_me_prev_init=y_me_init;
    
    %% Calculate new initial values
    y0_new_init(j)=y_me_init(2);
    
    %% Calculting stepsizes for each deltay and its time
    if j>=2
        deltay=(y0_new_init(j)-y0_new_init(j-1))./(time_init(j)-time_init(j-1));
        alpha=0.01;
        StepSizeCal=(alpha.*(abs(1./deltay)));
        TimeVector1= [time_init(j-1):StepSizeCal:time_init(j)];
        dcdt(j)=deltay;
        StepSizeVector(j)=StepSizeCal;
        TimeNew{j}=TimeVector1;
        TimeVector1=cell2mat(TimeNew);
        
        
    end
    
    
end

y0_update_init=y0_new_init;

StepSizeVector(1)=[];

TimeVectorNew=sort(unique([T,TimeVector1]));
TimeNew(1)=[];

