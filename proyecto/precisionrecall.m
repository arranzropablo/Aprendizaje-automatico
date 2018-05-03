function [precision, recall] = precisionrecall(theta, X, Y, threshold)

    resultados = sigmoide((-1)*theta'*X')';

    actualpos = Y == 1;
    predictedpos = resultados >= threshold;
    truepos = actualpos + predictedpos == 2;
    precision = sum(truepos) / sum(predictedpos);
    recall = sum(truepos) / sum(actualpos);

endfunction
