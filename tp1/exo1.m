clc; clear; close all

load data1.mat;

A = [ ones(length(xapp), 1), xapp];

Ap = pinv(A);
theta_estime = Ap * yapp;

yapp_estime = theta_estime(1) + theta_estime(2) * xapp;


figure(1)
plot(xapp, yapp, 'rs')
grid()
hold on
plot(xapp, yapp_estime, 'b')


emod = norm(yapp_estime - yapp)^2;

yapp_new = theta_estime(1) + theta_estime(2) * xtest;
plot(xtest, ytest, 'ks')
legend("données", "régression linéaire", "données test")

emod2 = norm(yapp_new - ytest)^2;