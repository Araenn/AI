clc; clear; close all

load("fisheriris.mat");

X = meas(51:end, 3:4);

n = length(X);
m = size(X, 2);

c = zeros(n, 1);
c(1:n/2) = 1;
c(n/2+1:end) = -1;

e = 1 - c.*X;
H = c * c' .* (X * X' +1).^3;  
f = -ones(n, 1);  
C = 110;
Aeq = c';
beq = 0;
lb = zeros(n, 1);
ub = C * ones(n, 1);

alpha = quadprog(H, f, [], [], Aeq, beq, lb, ub);
w = sum(alpha .* c .* X);
indice = find(alpha > 0.5);

w0 = 1 - e - (w * X(indice(1)));
theta = [w0(2) w]';


%decision = w0 + X*w;
index1 = findClosestValueIndex(X(1:n/2, :), theta);
index2 = findClosestValueIndex(X(n/2+1:end, :), theta);

x1min=min(X(:,1));
x1max=max(X(:,1));
x1 = (x1min:0.01:x1max)';
x2min=min(X(:,2));
x2max=max(X(:,2));
b2 = (x2min:0.01:x2max)';
[Xg,Yg] = meshgrid(x1,b2);
f = zeros(size(Xg));
for i = 1:n
    K_i = (Xg * X(i, 1) + Yg * X(i, 2) + 1).^3;
    f = f + alpha(i) * c(i) * K_i;
end
fp = sign(f);

figure(1)
imagesc(x1,b2,fp);
axis xy
colormap('sky')
colorbar
hold on
plot(X(1:n/2, 1), X(1:n/2, 2), 'xg')
plot(X(n/2+1:end, 1), X(n/2+1:end, 2), 'xr')
plot(X(indice(c(indice)==1), 1), X(indice(c(indice)==1), 2), "sk")
plot(X(indice(c(indice)==-1), 1), X(indice(c(indice)==-1), 2), "sk")
legend("Données classe 1", "Données classe 2", "Vecteurs supports")