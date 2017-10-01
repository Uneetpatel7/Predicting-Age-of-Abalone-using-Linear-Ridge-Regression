function [ w ] = mylinridgereg(X, Y, lambda)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(X);
I = eye(n);
temp1 = inv((X.')*(X) + lambda*I);
temp2 = (X.')*(Y);
w = temp1 * temp2;
end

