%% loading sound
[S, Fs] = audioread('sound.wav');
%% adding eco
u = 0.4;
delayT = 0.5; %sec
delayFs = delayT * Fs;
dlyS = cat(1, S, zeros(delayFs,1)) +  cat(1, zeros(delayFs,1), u * S); 
dlySplayer = audioplayer(dlyS, Fs);
audiowrite('eco_voice.wav', dlyS, Fs);
%% 
n1 = delayFs;
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