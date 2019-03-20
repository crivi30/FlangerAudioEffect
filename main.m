% Cristian Vitali, univpm 2019 
% Attivare le funzioni desiderate mettendo a 1 
% le variabili FLAG

........... 1. INTERPOLAZIONE LINEARE  .............
FLAG1=0;        %  1-on , 0-off                    %
....................................................
M1=0000;        % ritardo intero in campioni       % 
ni1=0.50;       % parte frazionaria in campioni    % 
....................................................


........... 2. INTERPOLAZIONE ALL-PASS  ............
FLAG2=0;        %  1-on , 0-off                    %
....................................................
M2=0000;        % ritardo intero in campioni       %
ni2=0.33;       % parametro per parte fraziona:    % 
                %   delta = (1-ni2)/(1+ni2)        %
....................................................


............... 3. EFFETTO FLANGER .................
FLAG3=0;        %  1-on , 0-off                    %
....................................................
alpha=-0.200;   % 1 -> -1                          %
beta=0.7070;    % 0 -> 1                           %
gamma=0.7070;   % 0 -> 1                           %
D0=5.5;         % ritardo medio in ms              %
D1=4.5;         % variazione del ritardo in ms     %
f=0.500;        % freq. variazione ritardo         % 
FLAG=1;         % 1-lineare , 0-all-pass           %
SOUND3=1;       % 1-sound on , 0-sound off         %
....................................................



% INIZIALIZZAZIONI 

% caricamento file audio
[data,fs]=audioread('nomefile.wav'); data(:,1)=[];
% tempo di campionamento, campioni e vettore tempo
Tc=1/fs;
L=length(data);
tempo=0:Tc:(L-1)*Tc;



....... ESERCIZIO 1 - interpolazione lineare .........
......................................................
% Si realizza una funzione Matlab per l implementazione 
% di un interpolatore lineare e si effettua un'analisi 
% della risposta in frequenza


if( FLAG1 == 1)
    
   y1=linear_interp(data,ni1,M1);
   
   
   % -COMPARAZIONE SEGNALE DI INGRESSO E USCITA
   figure(1); 
   plot(tempo,data,tempo,y1)
   grid on;
   
   % -CALCOLO RISPOSTA MODULO DEL FILTRO
   % con 0.001 < ni < 1.2
   figure(2); 
   title('Module Response FIR'); 
   hold on;
   grid on;
   for ni=0.001:0.1:1.2
      b=[zeros(1,M1-1) 1-ni ni];
      [H,W]=freqz(b,1);
      plot(W/pi,10*log(abs(H)))
   end


   % -CALCOLO RISPOSTA FASE DEL FILTRO
   % con 0.001 < ni < 1.2
   figure(3); 
   hold on;
   grid on;
   for ni=0.001:0.1:1.2
      b=[zeros(1,M1-1 ) 1-ni ni]; 
      phasez(b,1);
   end
end    



....... ESERCIZIO 2 - interpolazione all-pass ........
......................................................
% Si realizza una funzione Matlab per l implementazione 
% di un interpolatore all-pass e si effettua un'analisi 
% della risposta in frequenza


if( FLAG2 == 1)
    
   y2=allpass_interp(data,ni2,M2);
   
   
   % -COMPARAZIONE SEGNALE DI INGRESSO E USCITA
   figure(4); 
   plot(tempo,data,tempo,y2)
   grid on;
   
   
   % -CALCOLO RISPOSTA MODULO DEL FILTRO
   % con 0.001 < ni < 1.2
   figure(5); 
   title('Module Response IIR'); 
   axis([0 1 -20 5]);
   hold on;
   grid on;
   for ni=0.001:0.1:1.2
      b=[zeros(1,M2-1) ni 1];
      a=[1 ni];
      [H,W]=freqz(b,a);
      plot(W/pi,10*log(abs(H)))
   end


   % -CALCOLO RISPOSTA FASE DEL FILTRO
   figure(6); 
   hold on;
   grid on;
   for ni=0.001:0.1:1.2
      b=[zeros(1,M2-1) ni 1];
      a=[1 ni]; 
      phasez(b,a);
   end
end    



........... ESERCIZIO 3 - effetto flanger ...........
.....................................................
%  Si realizza una funzione Matlab per l’implementazione 
%  di un circuito che esegue un effetto Flanger al 
%  segnale di ingresso. Si utilizza una seconda funzione 
%  per il calcolo del 'Time Variant Fractional Delay'



if( FLAG3 == 1 )
    
   y3=flanger(data,Tc,alpha,beta,gamma,D0,D1,f,FLAG);

   
   % -COMPARAZIONE SEGNALE DI INGRESSO E USCITA
   figure(7); 
   plot(tempo,data,tempo,y3)
   grid on;

   
   % -CALCOLO RISPOSTA MODULO DEL FILTRO
   % per D=D0-D1, D=D0, D=D0+D1
   figure(8);
   b=[ beta, zeros(1,floor(D0-D1-1)), gamma];
   a=[1, zeros(1,floor(D0-D1-1)), -alpha];
   [H,W]=freqz(b,a);
   plot(W/pi,10*log(abs(H)),'r'); hold on;

   b=[ beta, zeros(1,floor(D0-1)), gamma];
   a=[1, zeros(1,floor(D0-1)), -alpha];
   [H,W]=freqz(b,a);
   plot(W/pi,10*log(abs(H)),'b')
   
   b=[ beta, zeros(1,floor(D0+D1-1)), gamma];
   a=[1, zeros(1,floor(D0+D1-1)), -alpha];
   [H,W]=freqz(b,a);
   plot(W/pi,10*log(abs(H)),'g')
   title('Modulo del filtro');
   legend('D0-D1','D0','D0+D1');
     
      
  
   % -EFFETTO SEGNALE AUDIO
   if(SOUND3 == 1)
       % segnale originale
       sound(data,fs)
       % premi invio dopo aver ascoltato il segnale 
       % originale, per passare a quello modificato
       pause
       % segnale modificato
       sound(y3,fs)
   end
end
