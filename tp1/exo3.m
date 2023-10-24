clc; clear; close all

load data3.mat;

A3 = [ ones(length(xapp), 1), xapp, xapp.^2 xapp.^3, xapp.^4];
A4 = [ ones(length(xapp), 1), xapp, xapp.^2 xapp.^3, xapp.^4, xapp.^5];
A5 = [ ones(length(xapp), 1), xapp, xapp.^2 xapp.^3, xapp.^4, xapp.^5, xapp.^6];

Ap3 = pinv(A3);
Ap4 = pinv(A4);
Ap5 = pinv(A5);

theta_estime3 = Ap3 * yapp;
theta_estime4 = Ap4 * yapp;
theta_estime5 = Ap5 * yapp;

yapp_estime3 = theta_estime3(1) + theta_estime3(2) * xapp + theta_estime3(3) * xapp.^2 + theta_estime3(4) * xapp.^3 + theta_estime3(5) * xapp.^4;
yapp_estime4 = theta_estime4(1) + theta_estime4(2) * xapp + theta_estime4(3) * xapp.^2 + theta_estime4(4) * xapp.^3 + theta_estime4(5) * xapp.^4 + theta_estime4(6) * xapp.^5;
yapp_estime5 = theta_estime5(1) + theta_estime5(2) * xapp + theta_estime5(3) * xapp.^2 + theta_estime5(4) * xapp.^3 + theta_estime5(5) * xapp.^4 + theta_estime5(6) * xapp.^5 + theta_estime5(7) * xapp.^6;

figure(1)
plot(xapp, yapp, 'ks')
grid()
hold on
plot(xapp, yapp_estime3, 'b')
plot(xapp, yapp_estime4, 'g')
plot(xapp, yapp_estime5, 'k')

emod3 = norm(yapp_estime3 - yapp)^2;
emod4 = norm(yapp_estime4 - yapp)^2;
emod5 = norm(yapp_estime5 - yapp)^2;

yapp_new3 = theta_estime3(1) + theta_estime3(2) * xtest + theta_estime3(3) * xtest.^2 + theta_estime3(4) * xtest.^3 + theta_estime3(5) * xtest.^4;
yapp_new4 = theta_estime4(1) + theta_estime4(2) * xtest + theta_estime4(3) * xtest.^2 + theta_estime4(4) * xtest.^3 + theta_estime4(5) * xtest.^4 + theta_estime4(6) * xtest.^5;
yapp_new5 = theta_estime5(1) + theta_estime5(2) * xtest + theta_estime5(3) * xtest.^2 + theta_estime5(4) * xtest.^3 + theta_estime5(5) * xtest.^4 + theta_estime5(6) * xtest.^5 + theta_estime5(7) * xtest.^6;

plot(xtest, ytest, 'rs')
legend("données", "régression polynomiale", "données test")

emod_new3 = norm(yapp_new3 - ytest)^2;
emod_new4 = norm(yapp_new4 - ytest)^2;
emod_new5 = norm(yapp_new5 - ytest)^2;