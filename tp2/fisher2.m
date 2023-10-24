clc; clear; close all

load("fisheriris.mat");

X = meas;
n = length(species);
c = zeros(n, 1);
c(1:50) = 1;
c(51:100) = 2;
c(101:150) = 3;

X1 = [X(:, 3) X(:, 4)];
c1 = [c(1:50); c(51:100)];

P = 0.5;

o = cvpartition(100, 'holdout', P);
idapp = training(o, 1);
idtest = ~idapp;
xapp = X1(idapp, :);
xtest = X1(idtest, :);
capp = c1(idapp, :);
ctest = c1(idtest, :);

z = (capp == 1);
xm = [xapp(:, 1) xapp(:, 2)]';
phim = [ones(1, length(xm)); xm];
PHI = phim';

theta = zeros(3,1);




J = 100;
k = 1;
while J > 10^-3 
    p = 1 ./ (1 + exp(-PHI * theta));
    D = p.*(1-p) .* eye(50);

    H = PHI' * D * PHI;
    G = -PHI' * (z - p);
    theta = theta - inv(H) * G;

    J = sum(log(1 + exp(PHI.*theta)) - z .* theta' .* PHI);
    k = k + 1;
end
