File = ['linregdata'];
datasize=4177;
f = fopen(File, 'r');
C = textscan(f, '%c%f%f%f%f%f%f%f%f%d', 'Delimiter', ',');
input = zeros(datasize,7);
temp = zeros(datasize,1);
temp2 = zeros(datasize,3);
temp(:,1)=C{1};

for i=1:datasize
    if(temp(i) == 70)
        temp2(i,1)=1;
    end
    if(temp(i) == 73)
        temp2(i,2)=1;
    end
    if(temp(i) == 77)
        temp2(i,3)=1;
    end
end
% temp2


for i=2:8
      input( :, i-1)= C{i};
end

final = horzcat(temp2,input);
M = mean(final);
S = std(final);
[m,n] = size(final);
stndrd = zeros(m,n);
for j=1:n
    for i=1:m
        stndrd(i,j) = [final(i,j) - M(1,j)]/S(1,j);
    end
end
stndrd;

% a = ones(datasize,1)

a = zeros(datasize,1);
for i =1:datasize
     a(i) =1;
end

fiX= horzcat(a,stndrd);
[m,n] = size(fiX);
Y = C{9};
[traini, testi] = gen_random(0.2 , datasize);

[p,d] = size(traini);
[q,k] = size(testi);

train = zeros(p,n);
test = zeros(q,n);
ytr = zeros(p,1);
yt = zeros(q,1);
for i=1:p
    train(i,:) = fiX(traini(i),:);
    ytr(i) = Y(traini(i));
end

for i=1:q
    test(i,:) = fiX(testi(i),:);
    yt(i) = Y(testi(i));
end


w = mylinridgereg(test, yt, 2); 
age =  mylinridgeregeval( test , w );
disp('The mean squared error by taking all attributes.');
err = meansquarederr(age, yt , q)
trump = w;
for k = 1:length(trump)
    trump(k) = abs(trump(k));
end

tu = sort(trump);

length(w);
for k = 1:length(w)
    if(abs(w(k) == tu(1)))
        w(k) = 0;
    end

    if(abs(w(k) == tu(2)))
        w(k) = 0;
    end
    if(abs(w(k) == tu(3)))
        w(k) = 0;
    end
end
w;


age2 =  mylinridgeregeval( test , w );
disp('The mean squared error by ignoring least significant attributes.');
err2 = meansquarederr(age, yt , q)
