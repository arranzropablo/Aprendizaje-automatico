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
    [newX, maxim] = featureNormalize(X);

    printf("Primero entrenamos la red neuronal con una unica capa oculta de 3 neuronas \n");
    theta_inicial = [pesosAleatorios(columns(newX) + 1, 3)(:) ; pesosAleatorios(4, 2)(:)];

    opciones = optimset("GradObj", "on", "MaxIter", 250);
    tic;
    all_theta = fmincg(@(t) (costeRN(t, columns(newX), 3, 2, newX, y, 0.01)), theta_inicial, opciones);
    time = toc;
    printf("Se han calculado los valores de theta con un máximo de 250 iteraciones y un valor de regularización (lambda) = 0.01 \n");
    [cost, grad] = costeRN(all_theta, columns(newX), 3, 2, newX, y, 0.01);
    printf("El calculo ha durado %.2f segundos y se ha alcanzado un coste minimo de %f. \n", time, cost);
    %printf("Pulsa una tecla para mostrar los valores optimos de theta...");
    printf("Pulsa una tecla para continuar...");
    pause();
    printf("\n");
    %disp(theta);

    [percentage] = percentageNN(all_theta, newX, y, columns(newX), 3, 2);
    printf("Teniendo en cuenta que vamos a testear el porcentaje de acierto con los mismos datos que los que hemos usado para entrenar nuestro algoritmo, obtenemos un porcentaje de acierto de %.2f%% \n\n", percentage * 100);

    clear -x file opciones; 

    [datatrain, datacrossvalidation, datatest] = loadandrandomize(file);
    [X, y] = splitdatainvars(datatrain);
    [Xval, yval] = splitdatainvars(datacrossvalidation);
    [Xtest, ytest] = splitdatainvars(datatest);

    [newX, maxim] = featureNormalize([X ; Xval]);
    
    newXtest = Xtest ./ maxim;

    y = [y ; yval];

    printf("Ahora separaremos nuestro conjunto en dos subconjuntos de datos. El 80%% lo usaremos para entrenar la red neuronal y el otro 20%% para testear los resultados. \n");
    printf("Esta vez nuestra red neuronal tendrá una capa oculta con 10 neuronas \n");
    theta_inicial = [pesosAleatorios(columns(newX) + 1, 10)(:) ; pesosAleatorios(11, 2)(:)];
    fflush(stdout);

    tic;
    all_theta = fmincg(@(t) (costeRN(t, columns(newX), 10, 2, newX, y, 0.01)), theta_inicial, opciones);
    time = toc;
    printf("Se han calculado los valores de theta con un máximo de 250 iteraciones y un valor de regularización (lambda) = 0.01 \n");
    [cost, grad] = costeRN(all_theta, columns(newX), 10, 2, newX, y, 0.01);
    printf("El calculo ha durado %.2f segundos y se ha alcanzado un coste minimo de %f. \n", time, cost);
    %printf("Pulsa una tecla para mostrar los valores optimos de theta...");
    printf("Pulsa una tecla para continuar...");
    pause();
    printf("\n");
    %disp(theta);

    percentage = percentageNN(all_theta, newX, y, columns(newX), 10, 2);
    printf("Testeando el modelo con los datos de entrenamiento obtenemos un porcentaje de acierto de %.2f%% \n\n", percentage * 100);
    
    percentage = percentageNN(all_theta, newXtest, ytest, columns(newXtest), 10, 2);
    printf("Testeando el modelo con los datos de test obtenemos un porcentaje de acierto de %.2f%% \n", percentage * 100);
    printf("Consideramos este dato más valido ya que no son los datos que hemos usado para el entrenamiento \n\n ");

    printf("Ahora vamos a calcular el lambda que mejor clasifique nuestros datos. \n\n ");
    printf("Pulsa una tecla para continuar...");
    pause();
    printf("\n");

    clear -x file opciones theta_inicial; 

    [datatrain, datacrossvalidation, datatest] = loadandrandomize(file);
    [X, y] = splitdatainvars(datatrain);
    [Xval, yval] = splitdatainvars(datacrossvalidation);
    [Xtest, ytest] = splitdatainvars(datatest);

    [newX, maxim] = featureNormalize(X);
    
    newXval = Xval ./ maxim;

    newXtest = Xtest ./ maxim;

    lambda = [0.01, 0.03, 0.1, 0.3, 1, 3, 10];
    maxpercentage = 0;
    minvalcost = realmax;

    for i = 1:columns(lambda)
        
        printf("Vuelta %d/%d \n", i, columns(lambda));
        fflush(stdout);
        all_theta = fmincg(@(t) (costeRN(t, columns(newX), 10, 2, newX, y, lambda(:,i))), theta_inicial, opciones);
        percentage = percentageNN(all_theta, newXval, yval, columns(newXval), 10, 2)

        [jtrain(i), grad] = costeRN(all_theta, columns(newX), 10, 2, newX, y, lambda(:,i));
        [jval(i), grad] = costeRN(all_theta, columns(newX), 10, 2, newXval, yval, lambda(:,i));

        if(maxpercentage < percentage || (maxpercentage == percentage &&  jval(i) < minvalcost))
            minvalcost = jval(i);
            mincost = jtrain(i);
            maxpercentage = percentage;
            bestlambda = lambda(:,i);
            besttheta = all_theta;
        endif

    endfor

    mincost
    save curvadeevolucionlambdaNN.mat jtrain jval lambda;

    percentagetest = percentageNN(besttheta, newXtest, ytest, columns(newXtest), 10, 2);

    printf("El lambda optimo encontrado es %.2f que ha clasificado correctamente el %.2f%% de los datos de cross validation. \n", bestlambda, maxpercentage * 100);
    printf("Aplicando los datos de test sobre el modelo optimo encontrado obtenemos una clasificación correcta del %.2f%% de los datos. \n", percentagetest * 100);

    threshold = choosethreshold(besttheta, newXval, yval, columns(newX), 10, 2);
    [precision, recall] = precisionrecall(besttheta, newXtest, ytest, threshold, columns(newX), 10, 2);

    printf("Este algoritmo tiene una precision de %.2f%% y un recall de %.2f%%. Para estos calculos se ha calculado el threshold mas adecuado que es %.2f. \n", precision * 100, recall * 100, threshold);

    fflush(stdout);

    for i = 1:rows(newX)
        printf("Datos: %d/%d \n", i, rows(newX));
        fflush(stdout);

        all_theta = fmincg(@(t) (costeRN(t, columns(newX), 10, 2, newX(1:i,:), y(1:i,:), bestlambda)), theta_inicial, opciones);

        [jtrain(i), grad] = costeRN(all_theta, columns(newX), 10, 2, newX(1:i,:), y(1:i,:), bestlambda);
        [jval(i), grad] = costeRN(all_theta, columns(newX), 10, 2, newXval, yval, bestlambda);
    endfor

    save learningcurvesNN.mat jtrain jval;

endfunction