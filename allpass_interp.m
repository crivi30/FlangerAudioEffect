function y2=allpass_interp(x,ni2,M2)
      
L=length(x);
y2=zeros(L,1);
x1=zeros(L,1);

% -PARTE CON NI E M COSTANTE
% calcoloa uscita interpolata
for n=1:L
    if( n-M2 == 1 )   % primo caso
        x1(n) = x(n-M2); 
        y2(n) = ni2*x1(n); 
    elseif( n-M2-1 > 0 ) 
        x1(n) = x(n-M2) - ni2*x1(n-1);
        y2(n) = ni2*x1(n) + x1(n-1);
    end
end 
    