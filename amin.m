close all;clear;clc
syms x w
%% the functions
syms F1(x) F2(x) F3(x)
F1(x)=piecewise(x<0,0,(4>=x)&(x>=0),1,x>4,0);
%F2(x)=sin(x)*sin(2*x)/(x*pi)^2;
F3(x)=sin(100*x)*exp(-1j*pi*x);
%% this fucking shit
syms G1(w) G2(w) G3(w)
G1(w)=symsum(F1(x)*exp(-1j*w*x),x,0,4);
%G2(w)=symsum(F2(x)*exp(-1j*w*x),x,-100,100);
G3(w)=symsum(F3(x)*exp(-1j*w*x),x,-10,10);
n=-100:100;
H1=G1(n);
%H2=G2(n);
H3=G3(n);
%% Draw F1
figure 
subplot(3,1,1)
stem([-10:10],F1([-10:10]));
subplot(3,1,2)
plot(n,real(H1));
subplot(3,1,3)
plot(n,angle(H1));
%% Draw F2
% figure 
% subplot(3,1,1)
% stem([-10 10],F2([-10 10]));
% subplot(3,1,2)
% plot(n,real(H2));
% subplot(3,1,3)
% plot(n,angle(H2));
%% Draw F3
figure 
subplot(3,1,1)
stem([-10 10],F3([-10 10]));
subplot(3,1,2)
plot(n,real(H3));
subplot(3,1,3)
plot(n,angle(H3));