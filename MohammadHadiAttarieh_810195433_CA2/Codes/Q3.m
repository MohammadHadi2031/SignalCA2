%% loading sound
[S, Fs] = audioread('sound.wav');
msgbox({sprintf('Fs = %d',Fs), sprintf('Length = %d', numel(S))});
%% sampling
sampleDiff = round(Fs/4000);
sampleS = S(1:sampleDiff:end);
%sampleSplayer = audioplayer(sampleS,Fs);
%play(sampleSplayer); % no sound
%% new FS
sampleSplayer2 = audioplayer(sampleS, 4000);
play(sampleSplayer2);
%% obw
subplot(2, 1, 1);
obw(S, Fs);

subplot(2, 1, 2);
obw(sampleS, 4000);

%% reconst
  %% initialize
    %t = gpuArray(0:1/Fs:(numel(S)-1)/Fs);
    %sampleSgpu = gpuArray(sampleS);
     t = 0:1/Fs:(numel(S)-1)/Fs;
    sampleSgpu = sampleS;
  %% calculate
    tic
    reS = reconst(sampleS, t, 1/4000);
    toc
%% play recontructed sound
reSplayer = audioplayer(reS, Fs);
play(reSplayer);
%% compare two signal
subplot(2, 1, 1);
plot(S);
title('Original Signal');
subplot(2, 1, 2);
plot(reS);
title('Reconstructed Signal');
%% compare by fft
f = Fs*(0:L/2)/L;
Y = fft(S); 
Y = Y(1:L/2+1);
Y = abs(Y);

Y2 = fft(reS);
Y2 = Y2(1:L/2+1);
Y2 = abs(Y2);

subplot(2, 1, 1);
plot(f, Y);
title('fft of original sound');

subplot(2, 1, 2);
plot(f, Y2);
title('fft of reconstructed sound');
