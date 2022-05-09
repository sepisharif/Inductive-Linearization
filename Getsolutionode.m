%% ode45 solution
options=odeset('RelTol',1e-6);
solode=ode45(@odefunction,[minTime  maxTime], [y0],options,ka,v,vmax,km);  
rspl=deval(solode,T);
solu = rspl(2,:);
SOLU=solu./v;
