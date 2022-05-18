# JPKPD_Review
MATLAB_Codes

## Sepideh Sharif, 27/04/2022
The following code illustrates how Inductive Linearization (IL) compares to the ode45 reference solver. Along with the reference solver ode45, there are three ways of optimisation for IL.

1- Stopping rule
2- Adaptive step size
3- Smart update

- IL is used to solve a one-compartment Michaelis-Menten model after three optimization steps; all optimization steps are coded in the two separate m.files: 1) GetIndRel.m file (for the adaptive step size) and 2) GetIndRel2.m (for the fixed step size).

- Observed data were simulated using ode45 with an exponential residual error (sigma=0.1) and BSV (CV(31.6%)).

- For both methods, ode45 and optimized IL, the comparator metrics RunTime and Estimated parameters are compared.

##  Some general information:
- The MainRun m.file contains all function files and provides access to other m.files.

- The OLS.m file contains a switch case function for comparing the performance of the techniques; case 1 is ode45, and case 2 can be adjusted to match the optimised IL's parameters.

## The optimized steps are sequential and stack on top of one another:
NOTE-1: There are two alternatives for the adaptive (ss) or fixed (ss) codes in two unique m.files, 1) GetIndRel.m and 2) GetIndRel2.m, which can be used as case 2 of the switch for the preferred IL optimization strategy.

NOTE-2: For both techniques, ode45 followed by IL, the parameter estimations and runtimes were illustrated for five replicates (r=5).

## The setting for the adaptive step size
1- The adaptive step size settings (lines 9 and 8) are located in both the GetInitials1.m and GetInitials2.m files, respectively.

### The code is:

- %% Setting for the adaptive step size
  AdaptiveTime

2- Additionally, the OLS.m file has switch case2, for the adaptive step size lines (17-20).

### The codes are:

-  %% indlin solver for adaptive step size
     case 2
         GetIndlRel;
         solution = CorrespondingConc;

## The setting for the fixed step size
1- The setting section (lines 3–7) of both the GetInitials1.m and GetInitials2.m files should be used to specify the fixed step size.

### The codes are:

- %% Setting for the fixed step size
 GeneralInitials
 time=[minTime:stepsize: maxTime];
 

2- Additionally, in the OLS.m file, the switch has case 2 is the fixed step size, lines (22-25).

- %% Setting for the fixed step size
   case 2
        StepSize=stepsize;
        GetIndlRel2;
        solution = CorrespondingConc;
 
 ## The setting for Stopping rule
 1- Stopping rule for the adaptive step size is located in the GetIndlRel.m file between (129:146)

2- Stopping rule for the fixed step size is located in the GetIndlRel2.m file between (35:37)

### The codes are:

- %% Stopping rule
     if Loop1>1
        RelEr=max((abs(y0_update-y0_keep(Loop1-1,:))./y0_update));
        if RelEr < tolRelEf
        break
 
 ## The setting for Smart update
 1- Smart update for the adaptive step size is located in the GetIndlRel.m file line (135)

2- Smart update for the fixed step size is in the GetIndlRel2.m file line (42)

### The code is:

- %% Smart update
     y0_update=y0_keep(Loop1-1,:);
     
 ## The general settings
 1- The GeneralInitials.m file contains default initialisation values such as the fixed N (maxLin: maximum number of iterations) and fixed ss.

2- The threshold tol is defined as (tolRelEf) in the GeneralInitials.m file, with a default value of 1e-6.

3- The replication count, denoted by (r), is defined in the MainRun m.file, line 50.

4- The RelTol set for ode45 is in the MainRun m.file, line 51.

5- The option for the lsqnonlin (L-M algorithm) is in myFunction.m file,line 11. 

6- The dose defined in GeneralInitials.m file.

7- The sampling time (the same for both simulation and estimation) defined in GeneralInitials.m  file,

8- The parameters in the Getparameters.m file are the reference values.

9- the MainRun.m file should be executed to display the estimated parameters for ode45's five IDs (replications) followed by IL.

         
