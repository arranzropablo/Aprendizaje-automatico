function [theta, sigma, mu] = regresionmultidescgrad(ratioaprendizaje)  datos = load("data-p1/ex1data2.txt");

  columnas = columns(datos) + 1;
  for i = 0 : columnas - 2
    datos(:,columnas - i)=datos(:,(columnas - i) - 1)
  endfor
  datos(:,1)=1

  [X_norm, mu, sigma] = normalizaAtributo(datos);

  Y = X_norm (:,columns(X_norm));
  X_norm(:,columns(X_norm)) = [];
  X = X_norm;

  theta = zeros(1, columns(X_norm))
  diffuncost = 1
  m = rows(X_norm);

  while diffuncost > 0.0001
    
    #calculo funcion coste
    funcostanterior = (1/(2*m))*(((X_norm*theta') - Y)' * ((X_norm*theta') - Y));

    printf("Funcost: %f \n", funcostanterior)
    #recalculo theta
    sumatorio = ((X_norm*theta') - Y)' * X_norm;
    dif = (ratioaprendizaje/m) * sumatorio;
    theta = theta - dif;
    
    #calculo funcion coste
    funcost = (1/(2*m))*(((X_norm*theta') - Y)' * ((X_norm*theta') - Y));

    diffuncost = funcostanterior - funcost;
    
  endwhile
                         
endfunction