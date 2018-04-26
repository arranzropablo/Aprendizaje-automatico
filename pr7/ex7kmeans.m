function ex7kmeans()
  load("ex7data2.mat");
  K = 3;
  randidx = randperm(size(X, 1));
  centroids = X(randidx(1:K), :);
  [centroids, idx] = runkMeans(X, centroids, 10, true);
endfunction
