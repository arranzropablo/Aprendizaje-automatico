function [class, probs] = guessClass(X, theta)

    [probs, class] = max(sigmoide(X*theta'));

endfunction
