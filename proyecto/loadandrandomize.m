function loadandrandomize(name)

  data = load(name);
  [m,n] = size(data);
  idx = randperm(m);
  data_rand = data;
  data_rand(idx, :) = data;

  datatrain = data(1:floor(0.6*m),:)
  datacrossvalidation = data(floor(0.6*m):floor(0.8*m),:)
  datatest = data(floor(0.8*m):end,:)

endfuntion
