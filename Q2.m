%% loading sound
[S, Fs] = audioread('sound.wav');
%% adding eco
u = 0.4;
delayT = 0.5; %sec
n1 = delayT * Fs;
dlyS = cat(1, S, zeros(n1,1)) +  cat(1, zeros(n1,1), u * S); 
dlySplayer = audioplayer(dlyS, Fs);
audiowrite('eco_voice.wav', dlyS, Fs);
%% custom method for removing noise
nsf = dlyS; % noise free sound
for k =1:floor(numel(S)/n1) -1
   nsf((1:n1) + k*n1) = nsf((1:n1) + k*n1) -  u*nsf((1:n1) + (k-1)*n1);
end
% 
k = k+1;
n1 = mod(numel(S), n1);
nsf((1:n1) + k*n1) = nsf((1:n1) + k*n1) -  u*nsf((1:n1) + (k-1)*n1);
%
nsf = nsf(1:numel(S));
nsfplayer = audioplayer(nsf, Fs);

%% removing eco with Z transform
NUM = 1;
DEN = [1 zeros(1,n1-1) u];
ecofree= filter(NUM, DEN, dlyS);
ecofreeply=audioplayer(ecofree, Fs);
%% frequency response
freqz(DEN, NUM);
%% plot diff 
plot(ecofree(1:numel(S)) - S);
%% new eco
n1 = 0.3 * Fs;
n2 = 0.6 * Fs;
a1 = 0.5;
a2 = 0.25;
L = numel(S);

eco2 =cat(1, S , zeros(n2, 1));
eco2((1:L) + n1) = eco2((1:L) + n1) + a1 * S; 
eco2((1:L) + n2) = eco2((1:L) + n2) + a2 * S; 

eco2ply = audioplayer(eco2, Fs);
%% removing new eco
NUM = 1;
DEN = [1 zeros(1,n1-1) a1 zeros(1, n2 - n1 - 1) a2];
eco2free= filter(NUM, DEN, eco2);
eco2freeply = audioplayer(eco2free, Fs);




