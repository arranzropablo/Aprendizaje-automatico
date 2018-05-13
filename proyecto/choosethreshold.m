function threshold = choosethreshold(theta, X, y, num_entradas, num_ocultas, num_etiquetas)

    posiblethresholds = [0.4 : 0.01 : 0.6];
    maxf1 = 0;

    for i = 1:columns(posiblethresholds)

        if(exist("num_entradas", "var") && exist("num_ocultas", "var") && exist("num_etiquetas", "var"))
            [precision, recall] = precisionrecall(theta, X, y, posiblethresholds(:,i), num_entradas, num_ocultas, num_etiquetas);
        else
            [precision, recall] = precisionrecall(theta, X, y, posiblethresholds(:,i));
        endif
        f1score = 2 * ((precision * recall) / (precision + recall));

        if(maxf1 < f1score)
            maxf1 = f1score;
            threshold = posiblethresholds(:,i);
        endif

    endfor

endfunction