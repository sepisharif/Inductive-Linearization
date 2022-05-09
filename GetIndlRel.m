%% optimising IL, for the stopping rule and the adaptive step-size
for Loop1=1:maxLin 
    
    %% ME solution
    for Loop2=1:length(time)
     
        %% Applying the adaptive stepsize conditions
     if time(Loop2)<1
            StepSize=StepArray(1);
       
        elseif time(Loop2)<2
            StepSize=StepArray(2);
            
        elseif time(Loop2)<3
            StepSize=StepArray(3);
            
        elseif time(Loop2)<4
            StepSize=StepArray(4);
            
        elseif time(Loop2)<5
            StepSize=StepArray(5);
            
        elseif time(Loop2)<6
            StepSize=StepArray(6);
            
        elseif time(Loop2)<7
            StepSize=StepArray(7);
            
        elseif time(Loop2)<8
            StepSize=StepArray(8);
            
        elseif time(Loop2)<9
            StepSize=StepArray(9);
            
        elseif time(Loop2)<10
            StepSize=StepArray(10);
            
        elseif time(Loop2)<11
            StepSize=StepArray(11);
            
        elseif time(Loop2)<12
            StepSize=StepArray(12);
            
        elseif time(Loop2)<13
            StepSize=StepArray(13);
            
        elseif time(Loop2)<14
            StepSize=StepArray(14);
            
        elseif time(Loop2)<15
            StepSize=StepArray(15);
            
        elseif time(Loop2)<16
            StepSize=StepArray(16);
            
        elseif time(Loop2)<17
            StepSize=StepArray(17);
            
        elseif time(Loop2)<18
            StepSize=StepArray(18);
            
        elseif time(Loop2)<19
            StepSize=StepArray(19);
            
        elseif time(Loop2)<20
            StepSize=StepArray(20);
            
        elseif time(Loop2)<21
            StepSize=StepArray(21);
            
        elseif time(Loop2)<22
            StepSize=StepArray(22);
            
        elseif time(Loop2)<23
            StepSize=StepArray(23);
            
        elseif time(Loop2)<24
            StepSize=StepArray(24);
            
        elseif time(Loop2)<25
            StepSize=StepArray(25);
            
        elseif time(Loop2)<26
            StepSize=StepArray(26);
            
        elseif time(Loop2)<27
            StepSize=StepArray(27);
            
        elseif time(Loop2)<28
            StepSize=StepArray(28);
            
         elseif time(Loop2)<29
            StepSize=StepArray(29);
            
         elseif time(Loop2)<30
             StepSize=StepArray(30);
                  
     end
        
        CLt=vmax/(km + y0_update(Loop2));
        
        %% define EVD
        k20=-CLt/v;
        
        K=[-ka          0
            ka          k20];
        
        [P_m,Lam_m]=eig(K);
        Pinv=inv(P_m);
        MPart=P_m* (exp(Lam_m*StepSize).*eye(2)) * Pinv;
        
        if Loop2==1
            y_me = MPart*y0';
        else
            y_me = MPart*y_me_prev;
        end
        
        y_me_prev=y_me;
        
        %% Calculate new initial values
        y0_new(Loop2)=y_me(2);
        
    end
    
    y0_update=y0_new;
    y0_keep(Loop1,:)=y0_update;
    
    %% Stopping rule
     if Loop1>1
        RelEr=max((abs(y0_update-y0_keep(Loop1-1,:))./y0_update));
        
        if RelEr < tolRelEf 
            
     %% Smart update     
            y0_update=y0_keep(Loop1-1,:); 
          
            BreakFlag=1;
        else
            BreakFlag=0;
        end
    end
    
    if BreakFlag==1
        
        break
    end
    
end


CorreConc=interp1(time,y0_update,T,'linear');
CorrespondingConc=CorreConc./v;


