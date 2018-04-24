function saveContentToMat()
  vocabList = getVocabList();

  for i = 1:2551
    if (i > 0 && i < 10)
      file_contents = readFile(strcat('easy_ham/000',num2str(i),'.txt'));
    elseif (i > 9 && i < 100)
      file_contents = readFile(strcat('easy_ham/00',num2str(i),'.txt'));
    elseif (i > 99 && i < 1000)
      file_contents = readFile(strcat('easy_ham/0',num2str(i),'.txt'));
    elseif (i > 999 && i < 10000)
      file_contents = readFile(strcat('easy_ham/',num2str(i),'.txt'));
    endif

    email = processEmail(file_contents);

    email_splited = strsplit(email);

    email_as_vector = ismember(vocabList, email_splited);

    easy_ham(i, :) = email_as_vector;
    printf(strcat(num2str(i),'/3301 \n'));
    fflush(stdout);

  endfor

  easy_ham(:, columns(easy_ham) + 1) = 0;

  save easy_ham.mat;
  clear;
  vocabList = getVocabList();

  for i = 1:250
    if (i > 0 && i < 10)
      file_contents = readFile(strcat('hard_ham/000',num2str(i),'.txt'));
    elseif (i > 9 && i < 100)
      file_contents = readFile(strcat('hard_ham/00',num2str(i),'.txt'));
    elseif (i > 99 && i < 1000)
      file_contents = readFile(strcat('hard_ham/0',num2str(i),'.txt'));
    endif

    email = processEmail(file_contents);

    email_splited = strsplit(email);

    email_as_vector = ismember(vocabList, email_splited);

    hard_ham(i, :) = email_as_vector;
    printf(strcat(num2str(2551 + i),'/3301 \n'));
    fflush(stdout);

  endfor

  hard_ham(:, columns(hard_ham) + 1) = 0;

  save hard_ham.mat;
  clear;
  vocabList = getVocabList();

  for i = 1:500
    if (i > 0 && i < 10)
      file_contents = readFile(strcat('spam/000',num2str(i),'.txt'));
    elseif (i > 9 && i < 100)
      file_contents = readFile(strcat('spam/00',num2str(i),'.txt'));
    elseif (i > 99 && i < 1000)
      file_contents = readFile(strcat('spam/0',num2str(i),'.txt'));
    endif

    email = processEmail(file_contents);

    email_splited = strsplit(email);

    email_as_vector = ismember(vocabList, email_splited);

    spam(i, :) = email_as_vector;
    printf(strcat(num2str(2551 + 250 + i),'/3301 \n'));
    fflush(stdout);
  endfor

  spam(:, columns(spam) + 1) = 1;

  save spam.mat;
  clear;

endfunction
