function [ vector ] = MatToVec( matrix )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[rows,columns]= size(matrix);
vector=zeros(rows*columns, 1);

for i = 1:rows
    vector ((i-1)*columns+1:(i-1)*columns+columns)= matrix (i,:);
end
end

