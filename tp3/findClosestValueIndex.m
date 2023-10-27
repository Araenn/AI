function index = findClosestValueIndex(arr, targetValue)
    differences = abs(arr - targetValue);
    [~, index] = min(differences);
end
