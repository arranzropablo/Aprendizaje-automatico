function analyzeEmail()

  #leemos y procesamos
  file_contents = readFile('easy_ham/0024.txt');
  email = processEmail(file_contents);
  strfind(email, '')

  #habra que juntar spam con easy_spam (o con hard_spam, o con ambos, quizas hacer los 3 casos para ver cual va mejor)
  #y luego para cada correo ver que palabras del vocabulario tiene y ponerlas en los atributos y luego dependiendo si estaba en spam o en easy_ham o hard_ham poner la y a 0 o 1
  

endfunction
