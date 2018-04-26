function idx = findClosestCentroids(X, centroids)
  %idx es un vector mx1 donde guardamos cada centroide

  %para cada centroide
  for i = 1:rows(X)

    minnorma = norma(X(i, :), centroids(1, :)) ^ 2;
    idx(i,:) = 1;

    for j = 2:rows(centroids)

      n = norma(X(i, :), centroids(j, :));
      if (n < minnorma)
        minnorma = n;
        idx(i,:) = j;
      endif

    endfor
  endfor
endfunction
