function generarlcpol(X, y, lambda, Xval, yval, p)

  inittheta = ones(p, 1);

  X = generatepoldata(X, p);
  Xval = generatepoldata(Xval, p);

  [newX, mediaX, desvX] = featureNormalize(X);

  Xval = bsxfun(@minus, Xval, mediaX);
  newXval = bsxfun(@rdivide, Xval, desvX);

  for i = 1:rows(X)

    theta = fmincg(@(t)(coste(t,newX(1:i,:), y(1:i), lambda)),inittheta,optimset('GradObj', 'on', 'MaxIter', 200));
    [Jtrain(i), grad] = coste(theta, newX(1:i,:), y(1:i), lambda);

    [Jval(i), grad] = coste(theta, newXval, yval, lambda);

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
