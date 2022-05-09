%% optimising IL, for the stopping rule and the adaptive step-size
for Loop1=1:maxLin 
    
    %% ME solution
    for Loop2=1:length(time)
    
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


