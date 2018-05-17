function [percentage] = percentage(theta, X, Y)

    resultados = sigmoide(X*theta);

    resultadoscorrectos = sum(Y - resultados >= -0.5 & Y - resultados <= 0.5);

    percentage = resultadoscorrectos / rows(Y);

endfunction
