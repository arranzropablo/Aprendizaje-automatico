function [X, y, Xval, yval, Xtest, ytest] = loadandrandomize()

  %Cargamos easy_ham y lo reordenamos de manera aleatoria
  load('easy_ham.mat');
  [m_easy_ham,n] = size(easy_ham)
  idx = randperm(m_easy_ham);
  easy_ham_rand = easy_ham;
  easy_ham_rand(idx, :) = easy_ham;

  %Cargamos hard_ham y lo reordenamos de manera aleatoria
  load('hard_ham.mat');
  [m_hard_ham,n] = size(hard_ham)
  idx = randperm(m_hard_ham);
  hard_ham_rand = hard_ham;
  hard_ham_rand(idx, :) = hard_ham;

  %Cargamos spam y lo reordenamos de manera aleatoria
  load('spam.mat');
  [m_spam,n] = size(spam)
  idx = randperm(m_spam);
  spam_rand = spam;
  spam_rand(idx, :) = spam;

  datatrain_easy_ham = easy_ham_rand(1:floor(0.6*m_easy_ham),:);
  datacrossvalidation_easy_ham = easy_ham_rand(floor(0.6*m_easy_ham)+1:floor(0.8*m_easy_ham),:);
  datatest_easy_ham = easy_ham_rand(floor(0.8*m_easy_ham)+1:end,:);

  datatrain_hard_ham = hard_ham_rand(1:floor(0.6*m_hard_ham),:);
  datacrossvalidation_hard_ham = hard_ham_rand(floor(0.6*m_hard_ham)+1:floor(0.8*m_hard_ham),:);
  datatest_hard_ham = hard_ham_rand(floor(0.8*m_hard_ham)+1:end,:);

  datatrain_spam = spam_rand(1:floor(0.6*m_spam),:);
  datacrossvalidation_spam = spam_rand(floor(0.6*m_spam)+1:floor(0.8*m_spam),:);
  datatest_spam = spam_rand(floor(0.8*m_spam)+1:end,:);

  X = [datatrain_easy_ham ; datatrain_hard_ham ; datatrain_spam];
  y = X(:, end);
  X(:, end) = [];

  Xval = [datacrossvalidation_easy_ham ; datacrossvalidation_hard_ham ; datacrossvalidation_spam];
  yval = Xval(:, end);
  Xval(:, end) = [];

  Xtest = [datatest_easy_ham ; datatest_hard_ham ; datatest_spam];
  ytest = Xtest(:, end);
  Xtest(:, end) = [];

endfunction
