%% loading sound
[S, Fs] = audioread('Homayoun_Hafez.wav');
Splayer = audioplayer(S, Fs);
%% adding eco
% u = 0.4;
% delayT = 0.5; %sec
% delayFs = delayT * Fs;
% dlyS = cat(1, S, zeros(delayFs,1)) +  cat(1, zeros(delayFs,1), u * S); 
% dlySplayer = audioplayer(dlyS, Fs);
% audiowrite('eco_voice.wav', dlyS, Fs);
%% 
n1 =floor( Fs * (0.4));
nsf = S; % noise free sound
L = length(S);
u = 0.3;
for k =1:floor(L/n1) -1
   nsf((1:n1) + k*n1,1) = nsf((1:n1) + k*n1,1) -  u*nsf((1:n1) + (k-1)*n1,1);
    nsf((1:n1) + k*n1,2) = nsf((1:n1) + k*n1,2) -  u*nsf((1:n1) + (k-1)*n1,2);
end
% 
k = k+1;
n1 = mod(L, n1);
 nsf((1:n1) + k*n1,1) = nsf((1:n1) + k*n1,1) -  u*nsf((1:n1) + (k-1)*n1,1);
 nsf((1:n1) + k*n1,2) = nsf((1:n1) + k*n1,2) -  u*nsf((1:n1) + (k-1)*n1,2);
%
nsfplayer = audioplayer(nsf, Fs);