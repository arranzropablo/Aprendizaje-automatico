function [all_theta] = oneVsAll(X, y, num_etiquetas, lambda)

  initial_theta = zeros(columns(X),1);
  options = optimset('GradObj', 'on', 'MaxIter', 1500);

  for i = 1:num_etiquetas

    all_theta(i,:) = fmincg(@(t)(lrCostFunction(t, X, (y == i), lambda)), initial_theta, options);

  endfor

endfunction
