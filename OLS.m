%% Using OLS method for the objectie function
function [obj]= OLS(x0,method)
global  y0_update y

%% initials
GetInitials2

ka=exp(x0(1)); v=exp(x0(2)); vmax=exp(x0(3)); km=exp(x0(4));
switch method
    %% ode45 solver
    case 1
        
        Getsolutionode;
        solution = SOLU;
        
       %% indlin solver for adaptive step size
         case 2
         GetIndlRel;
         solution = CorrespondingConc;
        
        %% indlin solver for the fixed step size
%          case 2
%          StepSize=stepsize;
%          GetIndlRel2;
%          solution = CorrespondingConc;
         
end
%% calculating obj

obj=(solution-y)*(solution-y)';


end



