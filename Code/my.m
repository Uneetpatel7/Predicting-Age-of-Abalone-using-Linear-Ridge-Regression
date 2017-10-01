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
 M1 = mean(stndrd)
  S1 = std(stndrd)
x = [0.20 ;0.25; 0.30; 0.35; 0.40; 0.45; 0.50; 0.55];
[sizex_i,sizex_j] = size(x);
min_error = ones(sizex_i,1);
min_error = min_error.*1000;
min_lam = ones(sizex_i,1);
min_lam = min_error.*1000;
lam_p = zeros(100,1);
tunaa=1;
min_lamg = 100000;
min_fracg=100000;
min_errg = 100000;
for g = 0.05:0.05:5
    lam_p(tunaa) = g;
    tunaa = tunaa+1;
end

for b=1:sizex_i
m_error = zeros(100,1);        
m_errortr = zeros(100,1);
%for lam=0.05:0.05:5    
%m_error = 0;
for itr = 1:100    
[traini, testi] = gen_random(x(b) , datasize);

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
tuna=1;
for lam=0.05:0.05:5    
    
    
 w = mylinridgereg(train, ytr, lam) ;
 age =  mylinridgeregeval( test , w );
 agetr =  mylinridgeregeval( train , w );
 
 err = meansquarederr(age, yt , q);
 
 errtr = meansquarederr(agetr, ytr , p);
 m_error(tuna) = m_error(tuna) + err;
 if (err < min_error(b))
     min_error(b) = err;
     min_lam(b) = lam_p(tuna);
 if (err < min_errg)
    min_lamg = lam_p(tuna);
    min_fracg = x(b);
 end
 end
 m_errortr(tuna) = m_errortr(tuna) + errtr;
%  m_lam(tuna)= m_lam(tuna) + err; 
 tuna = tuna + 1; 
end

% plo(b,tuna) = m_error/100;
% tuna = tuna + 1;
end
 m_error = m_error./100;
 m_errortr = m_errortr./100;
 figure;
 plot(lam_p,m_error,'DisplayName','test MSerror');
 hold on;
 plot(lam_p,m_errortr,'DisplayName','train MSerror');
 title(sprintf('Fraction value %d', x(b)));
 xlabel(' 0.05<=Lamda <=5') % x-axis label
 ylabel('Meansquared error values') % y-axis label
 legend('show');
end
% m_error;
min_fracg;
min_lamg;
 figure(10);
 plot(x,min_error,'DisplayName','minimum average mean squared testing error');
 xlabel(' fraction') % x-axis label
 ylabel('minimum average mean squared testing error'); % y-axis label
 legend('show');

 figure(11);
 plot(x,min_lam,'DisplayName','lamda value that produced the minimum average mean squared testing error');
 xlabel(' fraction') % x-axis label
 ylabel('lamda value that produced minimum average mean squared testing error'); % y-axis label
 legend('show');



[traini, testi] = gen_random(min_fracg , datasize);

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

    
    
 figure(12);   
 w = mylinridgereg(train, ytr, lam) ;
 age =  mylinridgeregeval( test , w );
 agetr =  mylinridgeregeval( train , w );
 
 plot(age, yt, '.');
 hline = refline(1,0);
 title('plot between predicted and original test values');
 xlabel(' predicted datapoints') % x-axis label
 ylabel('original datapoints');
 
 figure(13);
 plot( agetr,ytr, '.');
 hline = refline(1,0);
 title('plot between predicted and original train values');
 xlabel(' predicted datapoints') % x-axis label
 ylabel('original datapoints');
 
fclose(f);


















