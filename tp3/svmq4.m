clc; clear; close all
rng(1); % For reproducibility
r = sqrt(rand(100,1)); % Radius
t = 2*pi*rand(100,1);  % Angle
data1 = [r.*cos(t), r.*sin(t)]; % Points
% Generate 100 points uniformly distributed in the annulus. The radius is again proportional to a square root, this time a square root of the uniform distribution from 1 through 4.
r2 = sqrt(3*rand(100,1)+1); % Radius
t2 = 2*pi*rand(100,1);      % Angle
data2 = [r2.*cos(t2), r2.*sin(t2)]; % points
% Plot the points, and plot circles of radii 1 and 2 for comparison.
figure;
plot(data1(:,1),data1(:,2),'r.','MarkerSize',15)
hold on
plot(data2(:,1),data2(:,2),'b.','MarkerSize',15)
ezpolar(@(x)1);ezpolar(@(x)2);
axis equal
hold off
X = [data1;data2];
c = ones(200,1);
c(1:100) = -1;

n = length(X);
m = size(X, 2);
e = 1 - c.*X;

% Modify the calculation of the matrix H
sigma = 0.2; % Set your desired value for sigma
H = zeros(n, n);
for i = 1:n
    for j = 1:n
        H(i,j) = c(i) * c(j) * exp(-norm(X(i,:) - X(j,:))^2 / (2 * sigma^2));
    end
end

f = -ones(n, 1);  
C = inf; % Set your desired value for C
Aeq = c';
beq = 0;
lb = zeros(n, 1);
ub = C * ones(n, 1);

alpha = quadprog(H, f, [], [], Aeq, beq, lb, ub);
w = sum(alpha .* c .* X);
indice = find(alpha > 0.5);

w0 = 1 - e - (w * X(indice(1)));
theta = [w0(2) w]';

% Modify the calculation of the decision function
x1min=min(X(:,1));
x1max=max(X(:,1));
x1 = (x1min:0.01:x1max)';
x2min=min(X(:,2));
x2max=max(X(:,2));
b2 = (x2min:0.01:x2max)';
[Xg,Yg] = meshgrid(x1,b2);
f= zeros(size(Xg));
for i = 1:n
    f = f + alpha(i) * c(i) * exp(-((Xg - X(i,1)).^2 + (Yg - X(i,2)).^2) / (2 * sigma^2));
end
fp = sign(f);

% Rest of the code remains the same
figure(2)
imagesc(x1,b2,fp);
axis xy
colormap('sky')
colorbar
hold on
plot(X(1:n/2, 1), X(1:n/2, 2), 'xg')
plot(X(n/2+1:end, 1), X(n/2+1:end, 2), 'xr')
plot(X(1:n/2, 1), X(1:n/2, 2), 'xg')
plot(X(n/2+1:end, 1), X(n/2+1:end, 2), 'xr')
plot(X(indice(c(indice)==1), 1), X(indice(c(indice)==1), 2), "sk") % Positive class support vectors
% plot(X(indice(c(indice)==-1), 1), X(indice(c(indice)==-1), 2), "sb") % Negative class support vectors