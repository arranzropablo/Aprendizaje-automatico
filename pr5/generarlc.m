function generarlc(inittheta, X, y, lambda, Xval, yval)

  for i = 1:rows(X)

    theta = fmincg(@(t)(coste(t,X(1:i,:), y(1:i), lambda)),inittheta,optimset('GradObj', 'on', 'MaxIter', 200));
    [Jtrain(i), grad] = coste(theta, X(1:i,:), y(1:i), lambda);

    [Jval(i), grad] = coste(theta, Xval, yval, lambda);

  endfor

  plot([1:1:rows(X)], Jtrain, 'LineWidth', 2);
  xlabel('Numero de ejemplos de entrenamiento')
  ylabel('Error')
  hold on;
  plot([1:1:rows(X)], Jval, 'LineWidth', 2);
  hold off;

  h = legend ({'Jtrain'}, 'Jval');
  legend (h, 'location', 'northeastoutside');
  set (h, 'fontsize', 20);

endfunction
