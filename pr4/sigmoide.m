function [sigmoide] = sigmoide(z)

    sigmoide = 1./(1+(e.^-z));

endfunction
