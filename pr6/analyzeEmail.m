function asd = analyzeEmail()

  #leemos y procesamos (esto lo hace saveContentToMat, asi que aqui solo cargamos y hacemos el randomizado y separamos en los subsets)

  #habra que juntar spam con easy_spam (o con hard_spam, o con ambos, quizas hacer los 3 casos para ver cual va mejor) y luego moverlos aleatoriamente y coger 60-20-20
  

  #data = load(name);
  #[m,n] = size(data);
  #idx = randperm(m);
  #data_rand = data;
  #data_rand(idx, :) = data;

  #datatrain = data(1:floor(0.6*m),:)
  #datacrossvalidation = data(floor(0.6*m):floor(0.8*m),:)
  #datatest = data(floor(0.8*m):end,:)

endfunction
