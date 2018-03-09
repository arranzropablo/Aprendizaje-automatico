function [sigmoide] = sigmoide(z)

    for i = 1:rows(z)
        for j = 1:columns(z)
            sigmoide(i,j) = 1/(1+ (e.^((-1)*z(i,j))));
        endfor
    endfor
endfunction
