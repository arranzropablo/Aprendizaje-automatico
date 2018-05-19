function svm()
    fflush(stdout);
    warning('off','all');

    addpath("SVM");
    file = "mushroomdata";

    printf("Aplicar Support Vector Machines. \n");
    printf("Pulsa una tecla para continuar...");
    % pause();
    printf("\n");

    load(file);
    [datatrain, datacrossvalidation, datatest] = loadandrandomize(file);
    [X, y] = splitdatainvars(datatrain);
    [Xval, yval] = splitdatainvars(datacrossvalidation);
    [Xtest, ytest] = splitdatainvars(datatest);

    printf("Primero entrenamos la Support Vector Machine con un kernel lineal\n");

    tic;
    linearModel = svmTrain(X, y, 1, @linearKernel, 1e-3, 20);
    time = toc;
    printf("Se ha calculado el modelo con un máximo de 20 iteraciones y un valor de C = 1 \n")
    printf("El calculo ha durado %.2f segundos\n", time);
    printf("Pulsa una tecla para continuar...");
    % pause();
    printf("\n");

    prediction = svmPredict(linearModel, X);
    percentage = sum(y == prediction)/rows(y);
    printf("Teniendo en cuenta que vamos a testear el porcentaje de acierto con los mismos datos que los que hemos usado para entrenar nuestro algoritmo, obtenemos un porcentaje de acierto de %.2f%% \n\n", percentage * 100);

    clear prediction percentage;

    prediction = svmPredict(linearModel, Xtest);
    percentage = sum(ytest == prediction)/rows(ytest);
    printf("Calculando el porcentaje de acierto sobre los datos de test obtenemos un porcentaje de acierto de %.2f%% \n\n", percentage * 100);

    clear prediction percentage;

    printf("Ahora entrenamos la Support Vector Machine con un kernel gaussiano\n");
    tic;
    gaussianModel = svmTrain(X, y, 1, @(x1,x2) gaussianKernel(x1,x2,0.1));
    time = toc;
    printf("El calculo ha durado %.2f segundos. \n", time);
    printf("Pulsa una tecla para continuar...");
    % pause();
    printf("\n");

    prediction = svmPredict(gaussianModel, X);
    percentage = sum(y == prediction)/rows(y);
    printf("Teniendo en cuenta que vamos a testear el porcentaje de acierto con los mismos datos que los que hemos usado para entrenar nuestro algoritmo, obtenemos un porcentaje de acierto de %.2f%% \n\n", percentage * 100);
    
    clear prediction percentage;

    prediction = svmPredict(gaussianModel, Xtest);
    percentage = sum(ytest == prediction)/rows(ytest);
    printf("Calculando el porcentaje de acierto sobre los datos de test obtenemos un porcentaje de acierto de %.2f%% \n\n", percentage * 100);

    clear prediction percentage;

    [model, C, sigma, percentagecv] = chooseCandsigma(X, y, Xval, yval);
    prediction = svmPredict(model, Xtest);
    percentage = sum(ytest == prediction)/rows(ytest);

    printf("Los valores para C y para sigma optimos son %.2f y %.2f respectivamente. \nEl porcentaje de acierto con esos valores en los datos de cross-validation es %.2f%% \nEl porcentaje de acierto sobre los datos de test es %.2f%% \n\n", C, sigma, percentagecv * 100, percentage * 100);

    truepos = ytest + prediction == 2;
    if (prediction == 0)
        precision = 1;
    else
        precision = sum(truepos) / sum(prediction);
    endif
    recall = sum(truepos) / sum(ytest);

    printf("Este algoritmo tiene una precision de %.2f%% y un recall de %.2f%%. \n", precision * 100, recall * 100);

endfunction