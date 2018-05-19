function [J, grad] = costereg(theta, X, y, lambda)
  valhipotesis = sigmoide(X*theta);
  m = rows(X);

  valory0 = (-y' * log(valhipotesis));

  valory1 = ((1 - y)' * log(1 - valhipotesis));

  J = (1/m)*(valory0-valory1) + (lambda/(2*m)) * [0;theta(2:rows(theta),:)]' * [0;theta(2:rows(theta),:)];

  grad = (1/m) * (X' * (valhipotesis - y) + lambda * [0;theta(2:rows(theta),:)]);
endfunction
