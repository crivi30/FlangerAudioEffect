function y2=allpass_interp(x,ni2,M2)
      
L=length(x);
y2=zeros(L,1);  % segnale di uscita 
x1=zeros(L,1);  % segnale ausiliario

for n=1:L
    if( n-M2 == 1 )   
        x1(n) = x(n-M2); 
        y2(n) = ni2*x1(n); 
    elseif( n-M2-1 > 0 )  
        x1(n) = x(n-M2) - ni2*x1(n-1);
        y2(n) = ni2*x1(n) + x1(n-1);
    end
end 
