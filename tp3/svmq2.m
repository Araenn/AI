clc; clear; close all

load("fisheriris.mat");

X = meas(1:100, 3:4);

n = length(X);
m = size(X, 2);

c = zeros(n, 1);
c(1:n/2) = 1;
c(n/2+1:end) = -1;

H = c .* (X * X') .* c';
f = -ones(n, 1);

Aeq = c';
beq = 0;
lb = zeros(n, 1);
ub = ones(n, 1);

alpha = quadprog(H, f, [], [], Aeq, beq, lb, ub);
w = sum(alpha .* c .* X);
indice = find(alpha > 0.1);
w0 = 1 - (w * X(indice(1)));
theta = [w0(1) w]';

x1min=min(X(:,1));
x1max=max(X(:,1));
x1 = (x1min:0.01:x1max)';

x2 =  -(theta(1) + theta(2) * x1)/ theta(3) ; %droite

%decision = w0 + X*w;
index1 = findClosestValueIndex(X(1:n/2, :), theta);
index2 = findClosestValueIndex(X(n/2+1:end, :), theta);

figure(1)
plot(X(1:n/2, 1), X(1:n/2, 2), 'x')
hold on
plot(X(n/2+1:end, 1), X(n/2+1:end, 2), 'x')
plot(x1, x2)
plot(X(index1, 1), X(index1, 2), "sb")
plot(X(n/2+index2, 1), X(n/2+index2, 2), "sr")
grid()

x2min=min(X(:,2));
x2max=max(X(:,2));
b2 = (x2min:0.01:x2max)';
[Xg,Yg] = meshgrid(x1,b2);
f= theta(2)*Xg + theta(3)*Yg + theta(1);
fp=-ones(size(Xg));
fp(f>=0)=1;

figure(2)
imagesc(x1,b2,fp);
axis xy
colormap('sky')
colorbar
hold on
plot(x1, x2, 'k', 'linewidth', 2)
plot(X(1:n/2, 1), X(1:n/2, 2), 'xg')
plot(X(n/2+1:end, 1), X(n/2+1:end, 2), 'xr')
plot(X(index1, 1), X(index1, 2), "sk")
plot(X(n/2+index2, 1), X(n/2+index2, 2), "sk")