function index = findClosestValueIndex(X, theta)
    for i = 1:ceil(length(X))
        x_point = X(i,1);
        y_point = X(i,2);
        distance(i) = abs((theta(1) + theta(2) * x_point + theta(3) * y_point) / sqrt(theta(2)^2 + theta(3)^2));
    end
    [~, index] = min(distance);
end
