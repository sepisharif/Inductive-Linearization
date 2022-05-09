function dxdy = odefunction(~,y,KA,V,VMAX,KM)

c=y(2)/V;
CLt=VMAX/(KM+c);
dxdy= [-KA*y(1)
KA*y(1)-CLt/V*y(2)];      
end