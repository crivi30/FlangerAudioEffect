function [M,ni]=TV_FDL(L,D0,D1,f,t,FLAG)

M=zeros(L,1);
ni=zeros(L,1);
delta=zeros(L,1);

% costruisco il vettore 'ritardo tempo variante'
D=D0+D1*sin(2*pi*f*t);

if(FLAG==1)
    % LINEARE 
    for n=1:L
        % parte intera
        M(n)=floor(D(n));
        % parte frazionaria
        ni(n)=D(n)-M(n);
    end

else
    % ALL-PASS
    for n=1:L
        % parte intera
        M(n)=floor(D(n));
        % parte frazionaria
        delta(n)=D(n)-M(n);
    end
    ni=(1.-delta)./(1.+delta);
end
