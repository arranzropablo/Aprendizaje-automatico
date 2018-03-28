function [num_wrongs] = checkTrainingCasesNN(X, Theta1, Theta2, y)
    num_wrongs = 0;
    [probs, class] = forwardprop(X, Theta1, Theta2);
    for i = 1:rows(X)
        if (class(1,i) == y(i))
            printf("class: %d , probs: %f \t ✓ \n", class(1, i), probs(1, i));
        else
            printf("class: %d , probs: %f , should be: %d (index: %d) \n", class(1, i), probs(1, i), y(i), i);
            num_wrongs += 1;
        endif
    endfor
endfunction
