function ex7img
  A = double (imread('bird_small.png')) ;

  A = A / 255;

  imagesc(A);
  X = reshape(A, rows(A) * columns(A), 3);

  K = 32;
  randidx = randperm(size(X, 1));
  centroids = X(randidx(1:K), :);
  [centroids, idx] = runkMeans(X, centroids, 10, true);

  for i = 1:rows(X)
    X_compressed(i, :) = centroids(idx(i),:);
  endfor

  X_compressed = reshape(X_compressed, rows(A), columns(A), 3);

  imagesc(X_compressed);
endfunction
