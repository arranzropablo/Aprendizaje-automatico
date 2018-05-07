function [perc] = percentageNN(theta, X, y, num_entradas, num_ocultas, num_etiquetas)

    num_wrongs = 0;
    [probs, class] = forwardprop(X, theta, num_entradas, num_ocultas, num_etiquetas);
    class = class .- 1;
    for i = 1:rows(X)
        if (class(1,i) != y(i,:))
            num_wrongs += 1;
        endif
    endfor

    perc = (rows(X) - num_wrongs) / rows(X);
endfunction