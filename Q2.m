%% loading sound
[S, Fs] = audioread('sound.wav');
%% adding eco
delayT = 0.5; %sec
delayFs = delayT * Fs;
dlyS = cat(1, S, zeros(delayFs,1)) +  cat(1, zeros(delayFs,1), 0.4 * S); 
dlySplayer = audioplayer(dlyS, Fs);
audiowrite('eco_voice.wav', dlyS, Fs);
%% 