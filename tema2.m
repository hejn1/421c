%Numar de ordine: 17
%Semnal dreptunghiular

P= 40; %perioada
D= 17; %durata
N= 50; %numarul de coeficienti
w0= 2*pi/P; %pulsatia unghiulara a semnalului
dutyCicle= 42.5;
pas= P/100;  % se regleza pasul de esantionare
t= -2*P:pas:2*P;


coef= zeros(1,N); % vector de coeficineti SFC
A= zeros(1,N); % vector de coeficienti SFA

x_sq= square(w0*t, dutyCicle); % semnalul initial ideal

x_initial=@(t,k) square(w0*t, dutyCicle).*exp(-1j*k*w0*t); % semnal inifial descompus in SFC
x_reconstruit= 0;

componenta_continua= (1/P)*integral(@(t) x_initial(t,0),0,P); % componenta continua a semnalului

for k = 1:1:50
    coef(k)= (1/P)*integral(@(t) x_initial(t,k - 25 ),0,P);
    x_reconstruit= x_reconstruit + coef(k)*exp(1j*(k - 25)*w0*t);
end
%calculam coeficientii SFC si reconstruim semnalul prin insumarea fiecarui termen

A(1)= abs(componenta_continua);

for k= 1:N
      A(k+1) = 2 * abs(coef(k)); 
      %calculam coeficientii Seriei Fourier Armonice care vor reprezenta amplitudinile din spectru
end

figure(1);
plot(t, x_reconstruit, t, x_sq),title('x(t)(linie solida) si reconstructia folosind N coeficienti (linie punctata)');

figure(2);
stem([0:N]*w0, A), title('Spectrul lui x(t)');
% reprezentam A in functie de frecventa fundamentala * numarul coeficientului corespunzator

%Conform cursului de SS, teoria seriilor Fourier (trigonometrica, armonica si complexa) ne spune
%ca orice semnal periodic poate fi aproximat printr-o suma infinita de sinusuri
%si cosinusuri de diferite frecvente, fiecare ponderat cu un anumit coeficient. 
%Acesti coeficienti reprezinta practic spectrul (amplitudinea pentru anumite frecvente).
%Semnalul reconstruit foloseste un numar finit de termeni(N=50 in tema) si se apropie ca
%forma de semnalul original, insa prezinta o marja de eroare. Cu cat marim
%numarul de coeficienti ai SF, aceasta marja de eroare va fi din ce in ce mai
%mica. In plus se observa faptul ca semnalul poate fi aproximat printr-o
%suma de sinusoide, variatiile semnalului prezentand un caracter sinusoidal.