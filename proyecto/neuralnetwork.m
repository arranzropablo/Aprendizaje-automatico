function neuralnetwork()
    fflush(stdout);
    warning('off','all');

    addpath("redesneuronales");
    file = "mushroomdata";

    printf("Aplicar redes neuronales. \n");
    printf("Pulsa una tecla para continuar...");
    pause();
    printf("\n");

    load(file);
    [X, y] = splitdatainvars(data);

    printf("Primero entrenamos la red neuronal con una unica capa oculta de 3 neuronas \n");
    theta_inicial = [pesosAleatorios(columns(X) + 1, 3)(:) ; pesosAleatorios(4, 2)(:)];

    opciones = optimset("GradObj", "on", "MaxIter", 50);
    tic;
    all_theta = fmincg(@(t) (costeRN(t, columns(X), 3, 2, X, y, 0.01)), theta_inicial, opciones);
    time = toc;
    printf("Se han calculado los valores de theta con un máximo de 50 iteraciones y un valor de regularización (lambda) = 0.01 \n");
    [cost, grad] = costeRN(all_theta, columns(X), 3, 2, X, y, 0.01);
    printf("El calculo ha durado %.2f segundos y se ha alcanzado un coste minimo de %f. \n", time, cost);
    %printf("Pulsa una tecla para mostrar los valores optimos de theta...");
    printf("Pulsa una tecla para continuar...");
    pause();
    printf("\n");
    %disp(theta);

    [percentage] = percentageNN(all_theta, X, y, columns(X), 3, 2);
    printf("Teniendo en cuenta que vamos a testear el porcentaje de acierto con los mismos datos que los que hemos usado para entrenar nuestro algoritmo, obtenemos un porcentaje de acierto de %.2f%% \n\n", percentage * 100);

    clear -x file opciones; 

    [datatrain, datacrossvalidation, datatest] = loadandrandomize(file);
    [auxX, auxy] = splitdatainvars(datatrain);
    [Xval, yval] = splitdatainvars(datacrossvalidation);
    [Xtest, ytest] = splitdatainvars(datatest);

    X = [auxX ; Xval];
    y = [auxy ; yval];

    printf("Ahora separaremos nuestro conjunto en dos subconjuntos de datos. El 80%% lo usaremos para entrenar la red neuronal y el otro 20%% para testear los resultados. \n");
    printf("Esta vez nuestra red neuronal tendrá una capa oculta con 10 neuronas \n");
    theta_inicial = [pesosAleatorios(columns(X) + 1, 10)(:) ; pesosAleatorios(11, 2)(:)];
    fflush(stdout);

    tic;
    all_theta = fmincg(@(t) (costeRN(t, columns(X), 10, 2, X, y, 0.01)), theta_inicial, opciones);
    time = toc;
    printf("Se han calculado los valores de theta con un máximo de 50 iteraciones y un valor de regularización (lambda) = 0.01 \n");
    [cost, grad] = costeRN(all_theta, columns(X), 10, 2, X, y, 0.01);
    printf("El calculo ha durado %.2f segundos y se ha alcanzado un coste minimo de %f. \n", time, cost);
    %printf("Pulsa una tecla para mostrar los valores optimos de theta...");
    printf("Pulsa una tecla para continuar...");
    pause();
    printf("\n");
    %disp(theta);

    percentage = percentageNN(all_theta, X, y, columns(X), 10, 2);
    printf("Testeando el modelo con los datos de entrenamiento obtenemos un porcentaje de acierto de %.2f%% \n\n", percentage * 100);
    
    percentage = percentageNN(all_theta, Xtest, ytest, columns(Xtest), 10, 2);
    printf("Testeando el modelo con los datos de test obtenemos un porcentaje de acierto de %.2f%% \n", percentage * 100);
    printf("Consideramos este dato más valido ya que no son los datos que hemos usado para el entrenamiento \n\n ");

    printf("Ahora vamos a calcular el lambda que mejor clasifique nuestros datos. Duración estimada: 15 mins. \n\n ");
    printf("Pulsa una tecla para continuar...");
    pause();
    printf("\n");

    lambda = [0.01, 0.1, 1, 10];
    maxpercentage = 0;
    X = auxX;
    y = auxy;

    for i = 1:columns(lambda)

        printf("Vuelta %d/%d \n", i, columns(lambda));
        fflush(stdout);
        all_theta = fmincg(@(t) (costeRN(t, columns(X), 10, 2, X, y, lambda(:,i))), theta_inicial, opciones);
        percentage = percentageNN(all_theta, Xval, yval, columns(Xval), 10, 2)

        if(maxpercentage < percentage)
            maxpercentage = percentage;
            bestlambda = lambda(:,i);
            %depende mucho de la aleatoriedad de los datos, porqe a veces lambda renta q sea 1, a veces 10 y a veces 0.01
            besttheta = all_theta;
        endif

        jtrain(i) = costeRN(all_theta, columns(X), 10, 2, X, y, lambda(:,i));
        jval(i) = costeRN(all_theta, columns(X), 10, 2, Xval, yval, lambda(:,i));

    endfor

    save curvadeevolucionlambdaNN.mat jtrain jval lambda;

    % plot(lambda, jtrain, 'LineWidth', 2);
    % xlabel('lambda')
    % ylabel('Error')
    % hold on;
    % plot(lambda, jval, 'LineWidth', 2);
    % hold off;

    % h = legend ({'jtrain'}, 'jval');
    % legend (h, 'location', 'northeastoutside');
    % set (h, 'fontsize', 20);

    percentagetest = percentageNN(besttheta, Xtest, ytest, columns(Xtest), 10, 2);

    printf("El lambda optimo encontrado es %.2f que ha clasificado correctamente el %.2f%% de los datos de cross validation. \n", bestlambda, maxpercentage * 100);
    printf("Aplicando los datos de test sobre el modelo optimo encontrado obtenemos una clasificación correcta del %.2f%% de los datos. \n", percentagetest * 100);

    %a parte del obtenido quizás hacer un caso en el q metemos algun threshold que priorice el decir q son venenosas no siendolo

    threshold = choosethreshold(besttheta, Xval, yval, columns(X), 10, 2);
    [precision, recall] = precisionrecall(besttheta, Xtest, ytest, threshold, columns(X), 10, 2);

    printf("Este algoritmo tiene una precision de %.2f%% y un recall de %.2f%%. Para estos calculos se ha calculado el threshold mas adecuado que es %.2f. \n", precision * 100, recall * 100, threshold);

    fflush(stdout);

    for i = 1:rows(X)
        printf("Datos: %d/%d \n", i, rows(X));
        fflush(stdout);

        all_theta = fmincg(@(t) (costeRN(t, columns(X), 10, 2, X(1:i,:), y(1:i,:), bestlambda)), theta_inicial, opciones);

        jtrain(i) = costeRN(all_theta, columns(X), 10, 2, X(1:i,:), y(1:i,:), bestlambda);
        jval(i) = costeRN(all_theta, columns(X), 10, 2, Xval, yval, bestlambda);
    endfor

    save learningcurvesNN.mat jtrain jval;
    % plot([1:1:rows(X)], jtrain, 'LineWidth', 2);
    % xlabel('Numero de ejemplos de entrenamiento')
    % ylabel('Error')
    % hold on;
    % plot([1:1:rows(X)], jval, 'LineWidth', 2);
    % hold off;

    % h = legend ({'jtrain'}, 'jval');
    % legend (h, 'location', 'northeastoutside');
    % set (h, 'fontsize', 20);

endfunction