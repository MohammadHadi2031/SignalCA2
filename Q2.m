%% loading sound
[S, Fs] = audioread('sound.wav');
%% adding eco
u = 0.4;
delayT = 0.5; %sec
n1 = delayT * Fs;
dlyS = cat(1, S, zeros(n1,1)) +  cat(1, zeros(n1,1), u * S); 
%% create player for echo sound
dlySplayer = audioplayer(dlyS, Fs);
audiowrite('eco_voice.wav', dlyS, Fs);
%% custom method for removing noise
    %% method one
    noEchoM1 = dlyS; % noise free sound
    for k =1:floor(numel(S)/n1) -1
       noEchoM1((1:n1) + k*n1) = noEchoM1((1:n1) + k*n1) -  u*noEchoM1((1:n1) + (k-1)*n1);
    end
    % 
    k = k+1;
    n1 = mod(numel(S), n1);
    noEchoM1((1:n1) + k*n1) = noEchoM1((1:n1) + k*n1) -  u*noEchoM1((1:n1) + (k-1)*n1);
    %
    noEchoM1 = noEchoM1(1:numel(S));
    ply_noEchoM1 = audioplayer(noEchoM1, Fs);
    
    %% method two (convolution)
    k = 3; % number of improvment
    ke = 0:k;
    g = zeros(k*n1 +1, 1);
    g(1 + ke * n1)= (-u).^ke;
    noEchoM2 = conv(g, dlyS);
    ply_noEchoM2= audioplayer(noEchoM2, Fs);
    %play(ply_noEcho2);
    diffArray = S - noEchoM2(1:numel(S));
    plot(diffArray);
    %accArr=(diffArray./S);
    %meanAcc = mean(abs(accArr(isinf(accArr)==0)),'omitnan');
    %stdofnoEcho = std(diffArray(isinf(diffArray)==0),'omitnan');
    %title(sprintf('std is %.4f', stdofnoEcho));
    %%
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
%%

plot(eco2free(1:L)- S);




