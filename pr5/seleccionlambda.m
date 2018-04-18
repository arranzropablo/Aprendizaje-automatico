function seleccionlambda(X, y, Xval, yval, Xtest, ytest, p)

  lambda = [0, 0.001, 0.003, 0.01, 0.03, 0.1, 0.3, 1, 3, 10];

  inittheta = ones(p + 1, 1);

  X = generatepoldata(X, p);
  Xval = generatepoldata(Xval, p);
  Xtest = generatepoldata(Xtest, p);

  [newX, mediaX, desvX] = featureNormalize(X);

  Xval = bsxfun(@minus, Xval, mediaX);
  newXval = bsxfun(@rdivide, Xval, desvX);

  Xtest = bsxfun(@minus, Xtest, mediaX);
  newXtest = bsxfun(@rdivide, Xtest, desvX);

for i = 1:columns(lambda)

    theta = fmincg(@(t)(coste(t, newX, y, lambda(i))),inittheta,optimset('GradObj', 'on', 'MaxIter', 200));
    [Jtrain(i), grad] = coste(theta, newX, y, 0);

    [Jval(i), grad] = coste(theta, newXval, yval, 0);

endfor

  plot(lambda, Jtrain, 'LineWidth', 2);
  xlabel('lambda')
  ylabel('Error')
  hold on;
  plot(lambda, Jval, 'LineWidth', 2);
  hold off;

  h = legend ({'Jtrain'}, 'Jval');
  legend (h, 'location', 'northeastoutside');
  set (h, 'fontsize', 20);

  theta = fmincg(@(t)(coste(t, newX, y, 3)),inittheta,optimset('GradObj', 'on', 'MaxIter', 200));
  [Jtest, grad] = coste(theta, newXtest, ytest, 0)

endfunction
