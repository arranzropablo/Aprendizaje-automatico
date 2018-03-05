function [X_norm, mu, sigma] = normalizaAtributo(X)

    for i = 1:columns(X)
        mu(i) = mean(X(:,i));
        sigma(i) = std(X(:,i));
        if(sigma(i) == 0)
            X_norm(:,i) = ones(rows(X))(:,i);
        else
            X_norm(:,i) = (X(:,i) - mu(i)) / sigma(i);
        endif
    endfor

endfunction
