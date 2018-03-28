function [num_wrongs] = checkTrainingCases(X, theta, y)
    num_wrongs = 0;
    for i = 1:rows(X)
        [probs, class] = max(sigmoide(X(i,:)*theta'));
        if (class == y(i))
            printf("class: %d , probs: %f \t ✓ \n", class, probs);
        else
            printf("class: %d , probs: %f , should be: %d (index: %d) \n", class, probs, y(i), i);
            num_wrongs += 1;
        endif
    endfor
endfunction
