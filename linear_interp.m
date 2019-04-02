function y1=linear_interp(x,ni1,M1)
 
L=length(x);
    
y1=zeros(L,1);       % segnale di uscita    
x_diff=zeros(L,1);   % segnale differenza
   
for n=1:L
   if( n-M1 == 1 )   
        x_diff(n)=-x(n-M1);
        y1(n)=x(n-M1)+ni1*x_diff(n);
   elseif( n-M1-1 > 0 )          
        x_diff(n)=x(n-M1-1)-x(n-M1);
        y1(n)=x(n-M1)+ni1*x_diff(n);
   end
end   
