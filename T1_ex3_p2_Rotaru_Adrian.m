function[]=T1_ex3_p2_Rotaru_Adrian(t,nr,niv,k)

figure((nr-1)*4+k)
hold on
title('Semnal dreptunghiular multinivel aleator'),xlabel('Timp [s]'),ylabel('A [V]')
%cu functia datasample procuram observatii despre vectorul niv
%functia rectpuls genereaza un impuls unitate dreptunghiular de durata 1/4
for n=0:0.25:40
    y = datasample(niv, 1);
    plot(t, y*rectpuls(t-n, 0.25))
end

end