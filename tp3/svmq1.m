clc; clear; close all

load("fisheriris.mat");

X = meas(1:100, 3:4);

n = length(X);
m = size(X, 2);

c = zeros(n, 1);
c(1:50) = 1;
c(51:end) = -1;

H = eye(m+1);
H(1, 1) = 0;
f = zeros(m+1, 1);
b = -ones(n, 1);
A = ones(m+1, n);
A(2:3, :) = X';
A = A' .* c * -1;

theta = quadprog(H, f, A, b);
w0 = theta(1);
w = theta(2:end);

x1min=min(X(:,1));
x1max=max(X(:,1));
x1 = (x1min:0.01:x1max)';

x2 = -(theta(1) + theta(2) * x1)/ theta(3); %droite

decision = w0 + X*w;
index1 = findClosestValueIndex(decision, -1);
index2 = findClosestValueIndex(decision, 1);

figure(1)
plot(X(1:50, 1), X(1:50, 2), 'x')
hold on
plot(X(51:end, 1), X(51:end, 2), 'x')
plot(x1, x2)
plot(X(index1), "s")
plot(X(index2), "s")
grid()


[Xg,Yg] = meshgrid(x1,x2);
f=theta(1)*Xg+theta(2)*Yg+theta(3);
fp=-ones(size(Xg));
fp(f>=0)=1;

figure(2)
imagesc(x1,x2,fp);
axis xy
colormap('summer')
colorbar