function y=reconst(x, t0, Ts)
N = numel(x);
n= (1:N-1)';
fun = @(t)sum(x(n).* sinc(t/Ts - n));
y = arrayfun(fun, t0);
end
