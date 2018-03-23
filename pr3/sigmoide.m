function [sigmoide] = sigmoide(z)

    sigmoide = 1/(1+e.^((-1)*z));

endfunction
