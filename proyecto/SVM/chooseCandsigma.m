function [model, bestC, bestsigma, percentagecv] = chooseCandsigma(X, y, Xval, yval)

vect = [0.01, 0.1, 1, 10];

bestnumcorrect = 0;

for i = 1:columns(vect)
  C = vect(i);

  for j = 1:columns(vect)
    sigma = vect(j);

    printf('Step %d', ((i - 1) * columns(vect)) + j);

    model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
    numcorrect = sum(svmPredict(model, Xval) == yval)

    if (numcorrect > bestnumcorrect)
      bestC = C;
      bestsigma = sigma;
      bestnumcorrect = numcorrect;
    endif

  endfor

endfor

model = svmTrain(X, y, bestC, @(x1, x2) gaussianKernel(x1, x2, bestsigma));
percentagecv = numcorrect / rows(Xval);

endfunction
