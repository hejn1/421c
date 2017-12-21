%Numar de ordine: 17
%Semnal dreptunghiular

P = 40; %perioada
D = 22; %durata
N = 50; %numarul de coeficienti
w0 = 2*pi/P; %pulsatia unghiulara a semnalului
t_sq = 0:0.02:D; %esantionarea semnalului original
x_sq = square((pi/12)*t_sq,0.5)/2+0.5; %semnalul triunghiular original
t = 0:0.02:P; %esantionarea semnalului modificat
x = zeros(1,length(t)); %initializare a semnalului modificat cu valori nule
x(t<=D) = x_sq; %modificam valorile nule cu valori din semnalul original
                %unde avem valori din t <= durata semnalului 
figure(1);
plot(t,x),title('x(t)(linie solida) si reconstructia folosind N coeficienti (linie punctata)'); %afisare x(t)
hold on;


for k = -N:N %k este variabila dupa care se realizeaza suma
    x_s = x_sq; %x_t e semnalul realizat dupa formula SF data
    x_s = x_s .* exp(-1i*k*w0*t_sq); %inmultire intre doua matrice element cu element
    X(k+N+1) = 0; %initializare cu valoare nula
    for i = 1:length(t_sq)-1
        X(k+N+1) = X(k+N+1) + (t_tr(i+1)-t_tr(i)) * (x_s(i)+x_s(i+1))/2; %reconstructia folosind coeficientii
    end
end

for i = 1:length(t) %i este variabila dupa care se realizeaza suma
    x_finit(i) = 0; %initializare cu valoare nula
    for k=-N:N
        x_finit(i) = x_finit(i) + (1/P) * X(k+51) * exp(1i*k*w0*t(i));  %reconstructia folosind coeficientii
    end
end
plot(t,x_finit,'--'); %afisare reconstructie semnal folosind cei N coeficienti

figure(2);
w=-50*w0:w0:50*w0; %w este vectorul ce ne va permite afisarea spectrului functiei
stem(w/(2*pi),abs(X)),title('Spectrul lui x(t)'); %afisarea spectrului