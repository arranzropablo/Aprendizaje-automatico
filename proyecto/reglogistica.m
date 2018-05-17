function reglogistica()
    fflush(stdout);
    warning('off','all');
    
    addpath("reglogistica");
    file = "mushroomdata";

    printf("Aplicar regresión logística regularizada. \n");
    printf("Pulsa una tecla para continuar...");
    pause();
    printf("\n");

    load(file);
    [X, y] = splitdatainvars(data);

    theta_inicial = zeros(columns(X) + 1, 1);
    X(:, 2:columns(X) + 1) = X;
    X(:, 1) = ones(rows(X), 1);

    opciones = optimset("GradObj", "on", "MaxIter", 500);
    tic;
    [theta, cost] = fminunc(@(t) (costereg(t, X, y, 0.01)), theta_inicial, opciones);
    time = toc;
	fflush(stdout);
    printf("Se han calculado los valores de theta con un máximo de 100 iteraciones y un valor de regularización (lambda) = 0.01 \n");
    printf("El calculo ha durado %.2f segundos y se ha alcanzado un coste minimo de %f. \n", time, cost);
    %printf("Pulsa una tecla para mostrar los valores optimos de theta...");
    printf("Pulsa una tecla para continuar...");
    pause();
	fflush(stdout);
    printf("\n");
    %disp(theta);

    [percentage] = percentage(theta, X, y);
    printf("Teniendo en cuenta que vamos a testear el porcentaje de acierto con los mismos datos que los que hemos usado para entrenar nuestro algoritmo, obtenemos un porcentaje de acierto de %.2f%% \n\n", percentage * 100);

    clear -x file theta_inicial opciones; 

    [datatrain, datacrossvalidation, datatest] = loadandrandomize(file);
    [X, y] = splitdatainvars(datatrain);
    [Xval, yval] = splitdatainvars(datacrossvalidation);
    [Xtest, ytest] = splitdatainvars(datatest);

    X(:, 2:columns(X) + 1) = X;
    X(:, 1) = ones(rows(X), 1);

    Xval(:, 2:columns(Xval) + 1) = Xval;
    Xval(:, 1) = ones(rows(Xval), 1);

    Xtest(:, 2:columns(Xtest) + 1) = Xtest;
    Xtest(:, 1) = ones(rows(Xtest), 1);

    printf("Ahora aplicaremos regresión logistica regularizada separando nuestro set de datos en 3 subconjuntos (train, cv y test). \n");
    printf("Pulsa una tecla para continuar...");
    pause();
    printf("\n");

    lambda = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
    maxpercentage = 0;

    for i = 1:columns(lambda)

        printf("Vuelta %d/%d \n", i, columns(lambda));
        fflush(stdout);
        [theta, cost] = fminunc(@(t) (costereg(t, X, y, lambda(:,i))), theta_inicial, opciones);
        percentageval = percentage(theta, Xval, yval);

        if(maxpercentage < percentageval)
            maxpercentage = percentageval;
            bestlambda = lambda(:,i);
            besttheta = theta;
            bestcost = cost;
        endif

        jtrain(i) = cost;
        [jval(i), grad] = costereg(theta,Xval,yval,lambda(:,i));

    endfor

    save curvadeevolucionlambdareglogistica.mat jtrain jval lambda;

    [percentagetest] = percentage(besttheta, Xtest, ytest);
    printf("El lambda optimo encontrado es %.2f que ha clasificado correctamente el %.2f%% de los datos de cross validation. \n", bestlambda, maxpercentage * 100);
    printf("Aplicando los datos de test sobre el modelo optimo encontrado obtenemos una clasificación correcta del %.2f%% de los datos. \n", percentagetest * 100);
    printf("Pulsa una tecla para continuar...");
    pause();
    printf("\n");

    threshold = choosethreshold(theta, Xval, yval);
    [precision, recall] = precisionrecall(besttheta, Xtest, ytest, threshold);

    printf("Este algoritmo tiene una precision de %.2f%% y un recall de %.2f%%. Para estos calculos se ha calculado el threshold mas adecuado que es %.2f. \n", precision * 100, recall * 100, threshold);

    fflush(stdout);

    for i = 1:rows(X)
        if(mod(i,1000) == 0)
            printf("Datos: %d/%d \n", i, rows(X));
            fflush(stdout);
        endif

        [theta, cost] = fminunc(@(t) (costereg(t, X(1:i,:), y(1:i,:), bestlambda)), theta_inicial, opciones);
        jtrain(i) = cost;
        [jval(i), grad] = costereg(theta, Xval, yval, bestlambda);
    endfor

    save learningcurvesreglogistica.mat jtrain jval;

endfunction