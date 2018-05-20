x = sampleS;
N = numel(x);
Ts = 1/4000;
n= (1:N)';
fun = @(t)sum(x(n).* sinc(t/Ts - n));
%% 
fun(1)