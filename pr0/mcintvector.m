function [valor] = mcintvector(fun, a, b,num_puntos)
    
  numAlX = rand(1, num_puntos) * (b - 1) + a;
  
  X=[a:0.001:b];
  res = fun(X);
  M = max(res);
   
  numAlY = rand(1, num_puntos) * M;
  
  resultados = fun(numAlX);
  resta = numAlY - resultados;
  ndebajo = sum(resta(:) < 0);
  
  valor = M * (b - a) * (ndebajo/num_puntos);
   
  
endfunction
