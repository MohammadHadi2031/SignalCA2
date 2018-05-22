%% loading sound
[S, Fs] = audioread('sound.wav');
msgbox({sprintf('Fs = %d',Fs), sprintf('Length = %d', numel(S))});
%% sampling
sampleDiff = round(Fs/4000);
sampleS = S(1:sampleDiff:end);
sampleSplayer = audioplayer(sampleS, Fs);
play(sampleSplayer); % no sound
%% new FS
sampleSplayer2 = audioplayer(sampleS, 4000);
play(sampleSplayer2);
%% obw
subplot(2, 1, 1);
obw(S, Fs);
subplot(2, 1, 2);
obw(sampleS, 4000);
%% reconst
t = 0:1/Fs:(numel(S)-1)/Fs;
reS = reconst(sampleS, t, 1/4000);
%reS =  arrayfun(reSfun, t);


%% play recontructed sound
reSplayer = audioplayer(reS, Fs);
play(reSplayer);