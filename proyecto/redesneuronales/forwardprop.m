function h = forwardprop(X, theta, num_entradas, num_ocultas, num_etiquetas)

  Theta1 = reshape(theta(1:num_ocultas * (num_entradas + 1)), num_ocultas, (num_entradas + 1));
  Theta2 = reshape(theta(1 + (num_ocultas * (num_entradas + 1)):end), num_etiquetas, (num_ocultas + 1));

  X(:,2:columns(X)+1) = X;
  X(:,1) = ones(rows(X),1);

  #Suponemos que viene añadida la bias unit
  z2 = Theta1 * X';
  a2 = sigmoide(z2);

  #añadimos bias unit
  a2(2:rows(a2)+1,:) = a2;
  a2(1,:) = ones(columns(a2),1);

  z3 = Theta2 * a2;
  h = sigmoide(z3);

endfunction
