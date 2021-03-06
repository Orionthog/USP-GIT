%% O que tem na planta
% Primeira Ordem
RPassaBaixa = 6.8E3;
CPassaBaixa = 22E-9;
%RPassaAlta  = 10E3;
%CPassaAlta  = 33E-9;
%Segunda Ordem
IndutSegOrd = 529.7E-3;
CapSegOrd = 96E-9;


FreqNat = 1/sqrt(IndutSegOrd*CapSegOrd);
Ganho = input('Digite o ganho: ');

% Fun��es de Transfer�ncia
%% Primeira Ordem
tf(1, [RPassaBaixa*CPassaBaixa, Ganho])
figure(1)
step(tf(1, [RPassaBaixa*CPassaBaixa, Ganho]))
ylim([0 1.2])
%% Segunda Ordem
figure(2)
step(tf(FreqNat^2, [1, 2*0.2*FreqNat, FreqNat^2]), 'r')
hold on
step(tf(FreqNat^2, [1, 2*1.0*FreqNat, FreqNat^2]), 'm')
step(tf(FreqNat^2, [1, 2*2.0*FreqNat, FreqNat^2]), 'c')
legend('Subamortecido \xi = 0,2','Criticamente Amortecido \xi = 1,0','Superamortecido \xi = 2,0')
hold off

%% Discuss�o Amort = 0
figure(3)
subplot(2,2,1)
step(tf(FreqNat^2, [1, 2*0.05*FreqNat, FreqNat^2]), 'c')
xlim([0 0.1])
title('\xi = 0,05')
subplot(2,2,2)
step(tf(FreqNat^2, [1, 2*0.01*FreqNat, FreqNat^2]), 'c')
xlim([0 0.1])
title('\xi = 0,01')
subplot(2,2,3)
step(tf(FreqNat^2, [1, 2*0.005*FreqNat, FreqNat^2]), 'c')
xlim([0 0.1])
title('\xi = 0,005')
subplot(2,2,4)
step(tf(FreqNat^2, [1, 2*0.001*FreqNat, FreqNat^2]), 'c')
xlim([0 0.1])
title('\xi = 0,001')

figure(4)
step(tf(FreqNat^2, [1, 2*0.000*FreqNat, FreqNat^2]), 'k')
title('\xi = 0,000')
%% Bode Te�rico
magrc = tf(1, [RPassaBaixa*CPassaBaixa, Ganho])
magrlc1 = tf(FreqNat^2, [1, 2*0.2*FreqNat, FreqNat^2])
magrlc2 = tf(FreqNat^2, [1, 2*1.0*FreqNat, FreqNat^2])
magrlc3 = tf(FreqNat^2, [1, 2*2.0*FreqNat, FreqNat^2])
%[Ganho/(sqrt(1-(1/RPassaBaixa*CPassaBaixa)^2*(RPassaBaixa*CPassaBaixa)^2))])
%fase =tf(-atan(1/(sqrt(RPassaBaixa*CPassaBaixa))*RPassaBaixa*CPassaBaixa))
figure(5)
bode(magrc)
title('Diagrama de bode do circuito RC')
figure(6)
bode(magrlc1)
title('Diagrama de bode do circuito RLC para \xi = 0,2')
figure(7)
bode(magrlc2)
title('Diagrama de bode do circuito RLC para \xi = 1,0')
figure(8)
bode(magrlc3)
title('Diagrama de bode do circuito RLC para \xi = 2,0')

MagPic = 1/(2*0.2*sqrt(1-(0.2^2)))
FreqRess = FreqNat*sqrt(1 - 2*(0.2^2))
%% Bode Experimental
tau = CPassaBaixa*RPassaBaixa
gama = 1.23/1.28 
opts = bodeoptions('cstprefs');
opts.FreqUnits = 'Hz';
spectrum = [10 100 500 1000 2000 5000 10000 20000];
figure(9)
bode(tf(gama, [tau 1]), spectrum , 'o-', opts)
title('Diagrama de bode do circuito RC')
figure(10)
bode(tf(gama*FreqNat^2, [1 2*0.2*FreqNat FreqNat^2]), spectrum, 'o-', opts)
title('Diagrama de bode do circuito RLC para \xi = 0,2')
figure(11)
bode(tf(gama*FreqNat^2, [1 2*1.0*FreqNat FreqNat^2]), spectrum, 'o-', opts)
title('Diagrama de bode do circuito RLC para \xi = 1.0')
figure(12)
bode(tf(gama*FreqNat^2, [1 2*2.0*FreqNat FreqNat^2]), spectrum, 'o-', opts)
title('Diagrama de bode do circuito RLC para \xi = 2.0')