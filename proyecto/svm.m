function svm()
    fflush(stdout);
    warning('off','all');

    addpath("SVM");
    file = "mushroomdata";

    printf("Aplicar Support Vector Machines. \n");
    printf("Pulsa una tecla para continuar...");
    pause();
    printf("\n");

    load(file);
    [X, y] = splitdatainvars(data);

    printf("Primero entrenamos la Support Vector Machine con un kernel lineal\n");

    % tic;
    % model = svmTrain(X, y, 1, @linearKernel, 1e-3, 20);
    % %esto tarda la vida entera, preguntar.
    % time = toc;
    % printf("Se ha calculado el modelo con un máximo de 20 iteraciones y un valor de C = 1 \n")
    % printf("El calculo ha durado %.2f segundos y se ha alcanzado un coste minimo de %f. \n", time, cost);
    % printf("Pulsa una tecla para continuar...");
    % pause();
    % printf("\n");

    printf("Ahora entrenamos la Support Vector Machine con un kernel gaussiano\n");
    tic;
    model = svmTrain(X, y, 1, @(x1,x2) gaussianKernel(x1,x2,0.1));
    time = toc;
    printf("El calculo ha durado %.2f segundos. \n", time);
    printf("Pulsa una tecla para continuar...");
    pause();
    printf("\n");

    % [percentage] = percentageNN(all_theta, X, y, columns(X), 3, 2);
    % printf("Teniendo en cuenta que vamos a testear el porcentaje de acierto con los mismos datos que los que hemos usado para entrenar nuestro algoritmo, obtenemos un porcentaje de acierto de %.2f%% \n\n", percentage * 100);

    % clear -x file opciones; 

    % [datatrain, datacrossvalidation, datatest] = loadandrandomize(file);
    % [auxX, auxy] = splitdatainvars(datatrain);
    % [Xval, yval] = splitdatainvars(datacrossvalidation);
    % [Xtest, ytest] = splitdatainvars(datatest);

    % X = [auxX ; Xval];
    % y = [auxy ; yval];

    % printf("Ahora separaremos nuestro conjunto en dos subconjuntos de datos. El 80%% lo usaremos para entrenar la red neuronal y el otro 20%% para testear los resultados. \n");
    % printf("Esta vez nuestra red neuronal tendrá una capa oculta con 10 neuronas \n");
    % theta_inicial = [pesosAleatorios(columns(X) + 1, 10)(:) ; pesosAleatorios(11, 2)(:)];
    % fflush(stdout);

    % tic;
    % all_theta = fmincg(@(t) (costeRN(t, columns(X), 10, 2, X, y, 0.01)), theta_inicial, opciones);
    % time = toc;
    % printf("Se han calculado los valores de theta con un máximo de 50 iteraciones y un valor de regularización (lambda) = 0.01 \n");
    % [cost, grad] = costeRN(all_theta, columns(X), 10, 2, X, y, 0.01);
    % printf("El calculo ha durado %.2f segundos y se ha alcanzado un coste minimo de %f. \n", time, cost);
    % %printf("Pulsa una tecla para mostrar los valores optimos de theta...");
    % printf("Pulsa una tecla para continuar...");
    % pause();
    % printf("\n");
    % %disp(theta);

    % percentage = percentageNN(all_theta, X, y, columns(X), 10, 2);
    % printf("Testeando el modelo con los datos de entrenamiento obtenemos un porcentaje de acierto de %.2f%% \n\n", percentage * 100);
    
    % percentage = percentageNN(all_theta, Xtest, ytest, columns(Xtest), 10, 2);
    % printf("Testeando el modelo con los datos de test obtenemos un porcentaje de acierto de %.2f%% \n", percentage * 100);
    % printf("Consideramos este dato más valido ya que no son los datos que hemos usado para el entrenamiento \n\n ");

    % printf("Ahora vamos a calcular el lambda que mejor clasifique nuestros datos. Duración estimada: 15 mins. \n\n ");
    % printf("Pulsa una tecla para continuar...");
    % pause();
    % printf("\n");

    % lambda = [0.01, 0.1, 1, 10];
    % maxpercentage = 0;
    % X = auxX;
    % y = auxy;

    % for i = 1:columns(lambda)

    %     printf("Vuelta %d/%d \n", i, columns(lambda));
    %     fflush(stdout);
    %     all_theta = fmincg(@(t) (costeRN(t, columns(X), 10, 2, X, y, lambda(:,i))), theta_inicial, opciones);
    %     percentage = percentageNN(all_theta, Xval, yval, columns(Xval), 10, 2)

    %     if(maxpercentage < percentage)
    %         maxpercentage = percentage;
    %         bestlambda = lambda(:,i);
    %         %depende mucho de la aleatoriedad de los datos, porqe a veces lambda renta q sea 1, a veces 10 y a veces 0.01
    %         besttheta = all_theta;
    %     endif

    % endfor
    
    % percentagetest = percentageNN(besttheta, Xtest, ytest, columns(Xtest), 10, 2);

    % printf("El lambda optimo encontrado es %.2f que ha clasificado correctamente el %.2f%% de los datos de cross validation. \n", bestlambda, maxpercentage * 100);
    % printf("Aplicando los datos de test sobre el modelo optimo encontrado obtenemos una clasificación correcta del %.2f%% de los datos. \n", percentagetest * 100);

    % %a parte del obtenido quizás hacer un caso en el q metemos algun threshold que priorice el decir q son venenosas no siendolo

    % threshold = 0.3;%choosethreshold(besttheta, Xval, yval, columns(X), 10, 2);
    % [precision, recall] = precisionrecall(besttheta, Xtest, ytest, threshold, columns(X), 10, 2);

    % printf("Este algoritmo tiene una precision de %.2f%% y un recall de %.2f%%. Para estos calculos se ha calculado el threshold mas adecuado que es %.2f. \n", precision * 100, recall * 100, threshold);
endfunction