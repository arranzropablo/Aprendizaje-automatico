function [precision, recall] = precisionrecall(theta, X, y, threshold, num_entradas, num_ocultas, num_etiquetas)

    if(exist("num_entradas", "var") && exist("num_ocultas", "var") && exist("num_etiquetas", "var"))
        resultados = forwardprop(X, theta, num_entradas, num_ocultas, num_etiquetas)(2,:)';
    else
        resultados = sigmoide(X*theta);
    endif

    actualpos = y == 1;
    predictedpos = resultados >= threshold;
    truepos = actualpos + predictedpos == 2;
    if (predictedpos == 0)
        precision = 1;
    else
        precision = sum(truepos) / sum(predictedpos);
    endif
    recall = sum(truepos) / sum(actualpos);

endfunction
