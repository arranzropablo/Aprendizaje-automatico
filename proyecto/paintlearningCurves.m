function paintlearningCurves()
    load("learningcurvesreglogistica.mat")
    plot([1:1:columns(jtrain)], jtrain, 'LineWidth', 2);
    xlabel('Numero de ejemplos de entrenamiento')
    ylabel('Error')
    hold on;
    plot([1:1:columns(jval)], jval, 'LineWidth', 2);
    hold off;

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