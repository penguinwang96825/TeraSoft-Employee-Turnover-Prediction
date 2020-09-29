% pkg install -forge io
% pkg install -forge dataframe
pkg load io
pkg load dataframe

##clear;
##clc;
##close all;

% a = 0.1 * (2/5) + 8 ** 7
% b = sin(0.8*pi)
% c = 10 ** (log(13)*6)
% d = exp(sqrt(5+8)/49)

% A = magic(5)
% a = A(1, :)
% b = A(3:4, 2:4)
% c = A(5, 1)
% d = A([2, 4], [2, 4, 5])

% T = csv2cell('train.csv');
% headers = T(1, :);
% data = T(2:end, 4:end);
% label = T(2:end, 3);
% data = cell2mat(data)
% label = cell2mat(label);

data = dataframe('train.csv');
