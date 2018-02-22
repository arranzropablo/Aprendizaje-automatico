function [valor] = mcint(fun, a, b,num_puntos)
  
  numAlX = rand(1, num_puntos) * (b - 1) + a;
  
  X=[a:0.001:b];
  res = fun(X);
  M = max(res);
   
  numAlY = rand(1, num_puntos) * M;
  
  resultados = fun(numAlX);
  ndebajo = 0;
  for i= 1: num_puntos
    
    if(numAlY(i) < resultados(i))
      ndebajo = ndebajo + 1;
    endif
    
  endfor
  
  valor = M * (b - a) * (ndebajo/num_puntos);
   

endfunction
