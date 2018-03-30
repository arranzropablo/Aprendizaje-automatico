function W = pesosAleatorios(L_in, L_out)

  W = rand(L_out, L_in + 1) * 2 * 0.12 - 0.12;

endfunction
