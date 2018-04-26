function centroids = computeCentroids(X, idx, K)

  for i = 1:K

    Ck = idx == i;
    sumatorio = zeros(1, columns(X));
    for j = 1:rows(Ck)
      if(Ck(j, :) == 1)
        sumatorio = sumatorio + X(j, :)
      endif
    endfor


    centroids(i, :) = sumatorio./sum(Ck);
  endfor

endfunction
