%% Aleph
[S, Fs]= audioread('sound_noisy.wav');
%% Beh
L = numel(S);
Y =fft(S);
Y = fftshift(Y);
Y = abs(Y/L);
f = Fs *(0:L-1)/L - Fs/2;
[SortY, SortYind] = sort(Y, 'desc');
plot(f, Y);
text(f(SortYind(1)), SortY(1)/2,sprintf('\\leftarrow fs = %d Hz',f(SortYind(1))));
text(f(SortYind(2)), SortY(2)*2/3,sprintf('\\leftarrow fs = %d Hz',f(SortYind(2))));
%% Jim(filter)
SfreeNoise =filter(Q1_Filter, S);
player=audioplayer(SfreeNoise,Fs);
%%play(player);
audiowrite('noise_free.wav', SfreeNoise, Fs);
%% mag and angle of filter
freqz(Q1_FilterNum);
%% new fliter (lowpass)
SfreeFilterd =filter(Q1_lowpassfilter, SfreeNoise);
player2=audioplayer(SfreeFilterd,Fs);
%play(player2);
audiowrite('modified.wav', SfreeFilterd, Fs);
%% Draw freeNoise and filtered freeNoise
figure('name','freeNoise and filtered freeNoise');
subplot(2,1,1);
plot(SfreeNoise);
title('Sound Free Noise');
subplot(2,1,2);
plot(SfreeFilterd);
title('Filterd Sound Free Noise');
%% fft of freeNoise and filtered freeNoise
Yf = abs(fftshift(fft(SfreeNoise)))/L;
YfLowpass = abs(fftshift(fft(SfreeFilterd)))/L;
figure('name','fft of freeNoise and filtered freeNoise');
f = (0:L-1)*Fs/L;
subplot(2,1,1);
plot(f, Yf);
title('fft of Sound Free Noise');
subplot(2,1,2);
plot(f, YfLowpass);
title('fft of Filterd Sound Free Noise');
%% mag and angle of lowpass filter
freqz(Q1_LowpassNum);





