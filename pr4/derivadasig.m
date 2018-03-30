function [derivadasig] = derivadasig(z)
  derivadasig = sigmoide(z) .* (1 - sigmoide(z));
endfunction
