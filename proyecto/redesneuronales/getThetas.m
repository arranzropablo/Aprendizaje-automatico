function [all_theta] = getThetas(X, y, lambda)

  initial_theta = [pesosAleatorios(401, 25)(:); pesosAleatorios(26, 10)(:)];
  options = optimset('GradObj', 'on', 'MaxIter', 50);

  all_theta = fmincg(@(t)(costeRN(t, 400, 25, 10, X, y, 1)), initial_theta, options);

endfunction
