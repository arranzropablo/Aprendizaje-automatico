function threshold = choosethreshold(theta, X, y)

    posiblethresholds = [0.4 : 0.01 : 0.6];
    maxf1 = 0;

    for i = 1:columns(posiblethresholds)

        [precision, recall] = precisionrecall(theta, X, y, posiblethresholds(:,i));
        f1score = 2 * ((precision * recall) / (precision + recall));

        if(maxf1 < f1score)
            maxf1 = f1score;
            threshold = posiblethresholds(:,i);
        endif

    endfor

endfunction