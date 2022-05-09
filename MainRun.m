%% The codes written by Sepideh Sharif

% Date: 27/04/2022, email: sepi.sharif@postgrad.otago.ac.nz
% This code relates to ("J Pharmacokinet Pharmacodyn UNDER REVIEW")
%-------------------------------------------------------------------------

%% This is the main run file
%-------------------------------------------------------------------------

%  Original model is based on:
%  Duffull SB, Hegarty G (2014)
%-------------------------------------------------------------------------
%-------------------------------------------------------------------------

% Step 1.  Optimize IL in two stages 

% stage 1. the stopping rule, RelEr < tolRelEf (from the GetIndlRel.m)
% stage 2. the adaptive step size based on dydt, StepSizeCal=(alpha.*(abs(1./deltay)))(from DCDT.m)


% Step 2.  Parameter estimation out puts: Runtime, ParameterEstimations

%-------------------------------------------------------------------------
clear all
clc
warning off
global y ReferenceValues
Getparameters
GetInitials1
options.Algorithm = 'levenberg-marquardt';
ReferenceValues=[1  1  0.2  0.5];
x0=log(ReferenceValues);

%% Two methods, method1:ode45, method2:IL
methods=[1,2];

%% Setting the population parameters
KA_theta=ReferenceValues(1);
V_theta=ReferenceValues(2);
VMAX_theta=ReferenceValues(3);
KM_theta=ReferenceValues(4);

%% Adding BSV
omega_KA=OMEGA(1,1);
omega_V=OMEGA(2,2);
omega_VMAX=OMEGA(3,3);
omega_KM=OMEGA(4,4);

rng(1)
r =5; % This is the number of replicate or IDs
options=odeset('RelTol',1e-3);
for i=1:r
    eps=normrnd(0, sigma,1,length(T));
   
    
    %% eta for all parameters
    eta_KA=normrnd(0,omega_KA);
    eta_V=normrnd(0,omega_V);
    eta_VMAX=mvnrnd(0,omega_VMAX);
    eta_KM=mvnrnd(0,omega_KM);
    
    %% Simulated Parameters
    KA= KA_theta*(exp(eta_KA));
    V=V_theta*(exp(eta_V));
    VMAX=VMAX_theta*(exp( eta_VMAX));
    KM=KM_theta*(exp( eta_KM));
    
    %% storing the simiulated parameters
    SIM_PARAM(i, :)= [KA V VMAX KM];
    sim_ka(i,:)=KA;
    sim_v(i,:)=V;
    sim_vmax(i,:)=VMAX;
    sim_km(i,:)=KM;
    
    %% Simulation by ode45
    sol=ode45(@odefunction,[minTime  maxTime], [y0],options,KA,V,VMAX,KM);
    rspl=deval(sol,T);
    y_SIM=rspl(2,:);
    y_sim_1= y_SIM./V;
    y_observed{i,:}=y_sim_1.*exp(eps);
    
end

%% Storing output for both ode45 and IL
for method=methods
    for j = 1:numel(y_observed)
        yOUT = cell2mat(y_observed([j]));
        y=yOUT;
        ActualParam = SIM_PARAM(j, :);
        tic
        [P,resnorm,exitflag]= myFunction(y,x0,method);
        thisTime=toc;
        runTime=thisTime;
        ParameterEstimated=exp(P);
        parameterDeviationPercentage=((ParameterEstimated-ActualParam)./ActualParam)*100;
        Obj=exitflag;
        disp(['sim-est run number is ',num2str(j)])
        %% Storing the estimation output
       RUNTIME(method,j)=runTime;
       PARAMETEReS{method,j}=ParameterEstimated;
        
    end
end

%% Table of the output
 ParaEst=cell2mat( PARAMETEReS);
 Para_Est_Ode45=array2table(ParaEst(1,:));
 Para_Est_Ode45.Properties.VariableNames = {'ka_1' 'v_1' 'vmax_1' 'km_1','ka_2' 'v_2' 'vmax_2' 'km_2','ka_3' 'v_3' 'vmax_3' 'km_3',...
     'ka_4' 'v_4' 'vmax_4' 'km_4','ka_5' 'v_5' 'vmax_5' 'km_5'}
 
 Para_Est_IL=array2table(ParaEst(2,:));
 Para_Est_IL.Properties.VariableNames = {'ka_1' 'v_1' 'vmax_1' 'km_1','ka_2' 'v_2' 'vmax_2' 'km_2','ka_3' 'v_3' 'vmax_3' 'km_3',...
     'ka_4' 'v_4' 'vmax_4' 'km_4','ka_5' 'v_5' 'vmax_5' 'km_5'}


Run_Time_Ode45=RUNTIME(1,:);
Run_Time_IL=RUNTIME(2,:);
TableRunTime=table(Run_Time_Ode45,Run_Time_IL)


Mean_RunTime_Ode45=mean(RUNTIME(1,:));
Mean_RunTime_IL=mean(RUNTIME(2,:));
TableMean=table(Mean_RunTime_Ode45,Mean_RunTime_IL)