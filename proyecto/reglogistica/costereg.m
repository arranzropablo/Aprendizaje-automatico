function [J, grad] = costereg(theta, X, y, lambda)
  valhipotesis = sigmoide(X*theta);
  m = rows(X);

  valory0 = (-y' * log(valhipotesis));

  %Como a veces los valores hacen que valhipotesis sea 1 por su cercanía al mismo
  %eso hace que se calcule el logaritmo de 0, que es infinito.
  %Eso arrastraba muchos errores así que hemos decidido sumarle un minimo valor al 1 para que no sea 0 la resta
  valory1 = ((1-y)' * log((1 + 1e-15)-valhipotesis));

  J = (1/m)*(valory0-valory1) + (lambda/(2*m)) * [0;theta(2:rows(theta),:)]' * [0;theta(2:rows(theta),:)];

  grad = (1/m) * (X' * (valhipotesis - y) + lambda * [0;theta(2:rows(theta),:)]);
endfunction
