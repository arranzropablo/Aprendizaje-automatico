function [X, y] = splitdatainvars(data)
    y = data(:, end);
    data(:, end) = [];
    X = data;
endfunction