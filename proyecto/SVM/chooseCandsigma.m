function [bestC, bestsigma] = chooseCandsigma(X, y, Xval, yval)

vect = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];

bestnumcorrect = 0;

for i = 1:columns(vect)
  C = vect(i);

  for j = 1:columns(vect)
    sigma = vect(j);

    printf('Step %d', ((i - 1) * columns(vect)) + j);

    %model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
    model = svmTrain(X, y ,C, @linearKernel, 1e-3, 20);
    numcorrect = sum(svmPredict(model, Xval) == yval)

    if (numcorrect > bestnumcorrect)
      bestC = C;
      bestsigma = sigma;
      bestnumcorrect = numcorrect;
    endif

  endfor

endfor

%model = svmTrain(X, y, bestC, @(x1, x2) gaussianKernel(x1, x2, bestsigma));
model = svmTrain(X, y ,C, @linearKernel, 1e-3, 20);
%visualizeBoundary(X, y, model);

endfunction
