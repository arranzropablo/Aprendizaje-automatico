function [theta] = regresionmultiecnormal()

    datos = load("data-p1/ex1data2.txt");

    columnas = columns(datos) + 1;
    for i = 0 : columnas - 2
        datos(:,columnas - i)=datos(:,(columnas - i) - 1)
    endfor
    datos(:,1)=1

    Y = datos (:,columns(datos));
    datos(:,columns(datos)) = [];
    X = datos;

    theta = pinv(X'*X)*X'*Y
                                                               
endfunction