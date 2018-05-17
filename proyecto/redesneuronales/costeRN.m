function [J, grad] = costeRN(params_rn, num_entradas, num_ocultas, num_etiquetas, X, y, lambda)

  X(:,2:columns(X)+1) = X;
  X(:,1) = ones(rows(X),1);

  Theta1 = reshape(params_rn(1:num_ocultas * (num_entradas + 1)), num_ocultas, (num_entradas + 1));
  Theta2 = reshape(params_rn(1 + (num_ocultas * (num_entradas + 1)):end), num_etiquetas, (num_ocultas + 1));
  #load("ex4weights.mat");

  for i = 1: num_etiquetas
    aux(:, i) = y == (i - 1);
  endfor

  #Forward-propagation

  y = aux;

  a1 = X;
  z2 = a1 * Theta1';
  a2 = sigmoide(z2);

  #Añadimos bias unit
  a2(:,2:columns(a2)+1) = a2;
  a2(:,1) = ones(rows(a2),1);

  z3 = a2 * Theta2';
  a3 = sigmoide(z3);

  valory0 = (-y .* log(a3));
  valory1 = ((1 - y) .* log(1-a3));

  J = (1/rows(X)) * sum(sum(valory0 - valory1));
  #quitar col

  reg = (lambda/(2*rows(X))) * (sum(sum(Theta1(:, 2:end) .^ 2)) + sum(sum((Theta2(:, 2:end) .^ 2))));
  J = J + reg;

  #Backpropagation
  sigma3 = a3 - y;
  sigma2 = Theta2(:, 2:end)'*sigma3' .* derivadasig(z2)';
  delta2 = sigma3' * a2;
  delta1 = sigma2 * a1;

  delta1(:,2:end) = delta1(:,2:end) + lambda * Theta1(:,2:end);
  delta2(:,2:end) = delta2(:,2:end) + lambda * Theta2(:, 2:end);

  grad = [((delta1 ./ rows(X)) (:)) ; ((delta2 ./ rows(X))(:))];

endfunction
