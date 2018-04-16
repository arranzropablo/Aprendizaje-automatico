function X = generatepoldata(X, p)

  for i=2:p
    X(:,i) = X(:,1).^i;
  endfor

endfunction
