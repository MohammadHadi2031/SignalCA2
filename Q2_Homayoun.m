%% loading sound
[Sh, Fs] = audioread('Homayoun_Hafez.wav');
Splayer = audioplayer(Sh, Fs);
%% removing eco
n1 = 0.3 * Fs;
n2 = 0.6 * Fs;
a1 = 0.5;
a2 = 0.25;

NUM = 1;
DEN = [1 zeros(1,n1-1) a1 zeros(1, n2 - n1 - 1) a2];
noEco= filter(NUM, DEN, Sh);
noEcoply = audioplayer(noEco, Fs);