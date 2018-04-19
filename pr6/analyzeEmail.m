function asd = analyzeEmail()

  #leemos y procesamos
  file_contents = readFile('easy_ham/0024.txt');
  email = processEmail(file_contents);

  email_asd = strsplit(email);
  vocabList = getVocabList();

  X = ismember(vocabList, email_asd);

  #esto de ismember crea un vector con 0s y 1s si esa palabra está, habría que hacer lo mismo para todos los correos una vez hecho lo q pone debajo

  #habra que juntar spam con easy_spam (o con hard_spam, o con ambos, quizas hacer los 3 casos para ver cual va mejor) y luego moverlos aleatoriamente y coger 60-20-20
  #y luego para cada correo ver que palabras del vocabulario tiene y ponerlas en los atributos y luego dependiendo si estaba en spam o en easy_ham o hard_ham poner la y a 0 o 1


endfunction
