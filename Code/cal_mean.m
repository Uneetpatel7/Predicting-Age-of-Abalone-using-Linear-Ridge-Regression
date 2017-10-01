function [ mean ] = cal_mean( A )
[m,n] = size(A);

mean = zeros(1,8);
for j=1:n
    sum = 0.0;
    for i=1:m
        sum = sum + A(i,j);
    end
    mean(1,j) = sum/m;
end

end

