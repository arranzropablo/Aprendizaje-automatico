function[J, grad] = lrCostFunction(theta, X, y, lambda)

  valhipotesis = sigmoide(X*theta);
  m = rows(X);

  valory0 = ((-1) * log(valhipotesis) * y);
  valory1 = (log(1-valhipotesis) * (1-y));

  Jsinreg = (1/m)*(valory0-valory1);
  regularizacion = (lambda/(2*m)) * sum((theta(2:rows(theta)).^2));
  J = Jsinreg + regularizacion;

  grad = ((1/m) * (valhipotesis - y') * X);
  regularizacion = ((lambda/m) * theta(2:rows(theta),:)');
  grad(1,2:rows(theta)) = grad(1,2:rows(theta)) + regularizacion;

  #esto arreglarlo para qe salga al reves el resultado
  grad = grad';

endfunction
