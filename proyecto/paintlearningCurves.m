function paintlearningCurves()
    load("learningcurvesNN.mat")
    plot([3000:1:columns(jtrain)], jtrain(3000:end), 'LineWidth', 2);
    xlabel('Numero de ejemplos de entrenamiento')
    ylabel('Error')
    % hold on;
    % plot([3000:1:columns(jval)], jval(3000:end), 'LineWidth', 2);
    % hold off;

    h = legend ({'jtrain'}, 'jval');
    legend (h, 'location', 'northeastoutside');
    set (h, 'fontsize', 20);

    % load("curvadeevolucionlambdaNN.mat");
    % plot(lambda, jtrain, 'LineWidth', 2);
    % xlabel('lambda')
    % ylabel('Error')
    % hold on;
    % plot(lambda, jval, 'LineWidth', 2);
    % hold off;

    % h = legend ({'jtrain'}, 'jval');
    % legend (h, 'location', 'northeastoutside');
    % set (h, 'fontsize', 20);
endfunction