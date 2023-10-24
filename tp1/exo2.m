clc; clear; close all

load data2.mat;

A1 = [ ones(length(xapp), 1), xapp, xapp.^2];
A2 = [ ones(length(xapp), 1), xapp, xapp.^2 xapp.^3];
A3 = [ ones(length(xapp), 1), xapp, xapp.^2 xapp.^3, xapp.^4, xapp.^5, xapp.^6, xapp.^7, xapp.^8, xapp.^9];

Ap1 = pinv(A1);
Ap2 = pinv(A2);
Ap3 = pinv(A3);

theta_estime1 = Ap1 * yapp;
theta_estime2 = Ap2 * yapp;
theta_estime3 = Ap3 * yapp;

yapp_estime1 = theta_estime1(1) + theta_estime1(2) * xapp + theta_estime1(3) * xapp.^2;
yapp_estime2 = theta_estime2(1) + theta_estime2(2) * xapp + theta_estime2(3) * xapp.^2 + theta_estime2(4) * xapp.^3;
yapp_estime3 = theta_estime3(1) + theta_estime3(2) * xapp + theta_estime3(3) * xapp.^2 + theta_estime3(4) * xapp.^3 + theta_estime3(5) * xapp.^4 + theta_estime3(6) * xapp.^5 + theta_estime3(7) * xapp.^6 + theta_estime3(8) * xapp.^7 + theta_estime3(9) * xapp.^8 + theta_estime3(10) * xapp.^9;

figure(1)
plot(xapp, yapp, 'rs')
grid()
hold on
plot(xapp, yapp_estime1, 'b')
plot(xapp, yapp_estime2, 'g')
plot(xapp, yapp_estime3, 'k')


emod1 = norm(yapp_estime1 - yapp)^2;
emod2 = norm(yapp_estime2 - yapp)^2;
emod3 = norm(yapp_estime3 - yapp)^2;

yapp_new1 = theta_estime1(1) + theta_estime1(2) * xtest + theta_estime1(3) * xtest.^2;
yapp_new2 = theta_estime2(1) + theta_estime2(2) * xtest + theta_estime2(3) * xtest.^2 + theta_estime2(4) * xtest.^3;
yapp_new3 = theta_estime3(1) + theta_estime3(2) * xtest + theta_estime3(3) * xtest.^2 + theta_estime3(4) * xtest.^3 + theta_estime3(5) * xtest.^4 + theta_estime3(6) * xtest.^5 + theta_estime3(7) * xtest.^6 + theta_estime3(8) * xtest.^7 + theta_estime3(9) * xtest.^8 + theta_estime3(10) * xtest.^9;

plot(xtest, yapp_new1, 'bs')
plot(xtest, yapp_new2, 'gs')
plot(xtest, yapp_new3, 'ks')
legend("données", "régression polynomiale", "données test")

emod_new1 = norm(yapp_new1 - ytest)^2;
emod_new2 = norm(yapp_new2 - ytest)^2;
emod_new3 = norm(yapp_new3 - ytest)^2;