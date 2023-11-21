clc; clear; close all

X = randn(10000, 1);
X = X - mean(X);
X = X/std(X);

x = abs(fft(X).^2);

sigma = 2;
mu = 10;
y = 1/(sqrt(2*pi)*sigma) * exp(-(X-mu).^2/2*sigma^2);

figure
plot(y)

figure
plot(x)