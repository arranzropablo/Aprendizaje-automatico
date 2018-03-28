function [probs, class] = forwardprop(X, Theta1, Theta2)
  #Suponemos que viene añadida la bias unit
  z2 = Theta1 * X';
  a2 = sigmoide(z2);

  #añadimos bias unit
  a2(2:rows(a2)+1,:) = a2;
  a2(1,:) = ones(columns(a2),1);

  z3 = Theta2 * a2;
  h = sigmoide(z3);

  [probs, class] = max(h);

endfunction
