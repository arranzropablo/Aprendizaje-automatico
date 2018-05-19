function [X_norm, maxim] = featureNormalize(X)

    maxim = max (X);
    X_norm = X ./ maxim;

end
