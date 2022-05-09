%% Estimation parameters by lsqnonlin

function [P,resnorm,exitflag]=myFunction(y,x0,method)
global  ReferenceValues

GetInitials1
x0=log(ReferenceValues);

%% Setting for lsqnonlin
options.Algorithm = 'levenberg-marquardt';
options=optimoptions('lsqnonlin', 'Display', 'off');
[P,resnorm,exitflag]=lsqnonlin(@OLS,x0,[],[],options,method);
end