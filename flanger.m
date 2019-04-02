function [y3]=flanger(x,Tc,alpha,beta,gamma,D0,D1,f,FLAG)

D0=floor((D0*1e-3)/Tc);   % da ms a campioni
D1=floor((D1*1e-3)/Tc);   % da ms a campioni
L=length(x);
t=0:Tc:L*Tc;
x1=zeros(L,1);
x2=zeros(L,1);
x_aux=zeros(L,1);
[M,ni]=TV_FDL(L,D0,D1,f,t,FLAG);


if( FLAG == 1 )    
    
    % -CON INTERPOLAZIONE LINEARE 
    for n=1:L
       
       % interplazione lineare di x1  
       % costruisco il vettore differenza x_aux
       % e x2
      if( n-M(n) == 1 )   %primo caso
         x_aux(n)=-x1(n-M(n));
         x2(n)=x1(n-M(n))+ni(n)*x_aux(n);
      elseif( n-M(n)-1 > 0 )          
         x_aux(n)=x1(n-M(n)-1)-x1(n-M(n));
         x2(n)=x1(n-M(n))+ni(n)*x_aux(n);
      end
                     
       %aggiornamento di x1
       x1(n)=x(n)-alpha*x2(n); 
                  
    end           
    
    % uscita con effetto audio
    y3= beta*x1+gamma*x2;

else
    
    % -CON INTERPOLAZIONE ALL-PASS
    for n=1:L
       
       % interplazione all-pass di x2
       % costruisco il vettore ausiliario x_aux
       % e x2
       if( n-M(n) == 1 )   % primo caso
          x_aux(n) = x1(n-M(n)); 
          x2(n) = ni(n)*x_aux(n); 
       elseif( n-M(n)-1 > 0 ) 
          x_aux(n) = x1(n-M(n)) - ni(n)*x_aux(n-1);
          x2(n) = ni(n)*x_aux(n) + x_aux(n-1);
       end
       
       % aggiornamento di x1
       x1(n)=x(n)-alpha*x2(n);
       
    end
    
    % uscita con effetto audio
    y3= beta*x1+gamma*x2; 
end
