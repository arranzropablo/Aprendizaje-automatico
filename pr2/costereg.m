function [J, grad] = costereg(theta, X, y, lambda)

  valhipotesis = sigmoide((-1)*theta'*X');
  m = rows(X);

  valory0 = ((-1) * y' * log(valhipotesis)');
  valory1 = ((1-y)' * log(1-valhipotesis)');

  J = (1/m)*(valory0-valory1) + (lambda/(2*m)) * sum((theta(2:rows(theta),:)).^2);

grad = ((-1/m) * (valhipotesis' - y)' * X + (lambda/m) * theta(2:rows(theta),:))(1, :);

endfunction
