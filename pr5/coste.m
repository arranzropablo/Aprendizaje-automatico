function [J, grad] = coste(theta, X, y, lambda)

  X(:,2:columns(X)+1) = X;
  X(:,1) = ones(rows(X),1);

  valhipotesis = X*theta;
  m = rows(X);

  J = ((1/(2*m))*(valhipotesis-y)' * (valhipotesis-y)) + (lambda/(2*m)) * sum((theta(2:end,:)).^2);

  grad = ((1/m) * (valhipotesis - y)' * X)';

  grad(2:end, :) = grad(2:end, :) + (lambda/m) * theta(2:end,:);

endfunction
