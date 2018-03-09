function [J, grad] = coste(theta, X, y)

  theta = theta';

  valhipotesis = sigmoide((-1)*theta*X');
  m = rows(X);

  valory0 = ((-1) * y' * log(valhipotesis)');
  valory1 = ((1-y)' * log(1-valhipotesis)');

  J = (1/m)*(valory0-valory1);

  grad = (1/m) * (valhipotesis' - y)' * X;

endfunction
