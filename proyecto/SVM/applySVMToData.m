function applySVMToData(X, y, Xval, yval, Xtest, ytest)

   [C, sigma] = chooseCandsigma(X, y, Xval, yval);

endfunction
