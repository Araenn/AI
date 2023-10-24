clc; clear; close all

load("data4.mat");

rng('default')
x = [x1, x2, x3];
M = length(y);
P = 0.5;

c = cvpartition(M, 'holdout', P);
idapp = training(c, 1);
idtest = ~idapp;
xapp = x(idapp, :);
yapp = y(idapp);
xtest = x(idtest, :);
ytest = y(idtest, :);

my = mean(yapp);
mx = mean(xapp);
sigmax = std(xapp);

xapp = (xapp - mx) ./ sigmax;

N = length(yapp);

lambda = (0:0.1:50)';
theta = zeros(N, 3);
for i = 1:3
    for j = 1:length(lambda)
        theta(i, j) = inv(xapp(:, i)' * xapp(:, i) + lambda(j) * eye(N)) \ xapp(:, i)' * yapp;
        %yestime(j) = my + theta(j, 1) * xapp(:, 1) + theta(j, 2) * xapp(:, 2) + theta(j, 3) * xapp(:, 3);
        %yestime(j) = my + theta(1, 1) * xapp(:, 1) + theta(1, 2) * xapp(:, 2) + theta(1, 3) * xapp(:, 3);
    end
end
yestime = my + theta(:, 1) * xapp(:, 1) + theta(:, 2) * xapp(:, 2) + theta(:, 3) * xapp(:, 3);
figure(1)
plot(xapp, yapp, 'ks')
grid()
