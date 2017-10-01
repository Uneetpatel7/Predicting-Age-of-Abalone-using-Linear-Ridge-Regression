function [traini , testi ] = gen_random( x ,datasize)

ntr = floor(x*datasize);
 %ntr
temp = zeros(datasize,1);
for i=1:datasize
    temp(i) = i;
end

temp1=zeros(datasize,1);
temp1=temp(randperm(length(temp)));
%temp1;

traini = zeros(ntr,1);
testi = zeros(datasize-ntr,1);
traini(1:ntr, 1) = temp1(1:ntr, 1);
testi(1:datasize-ntr, 1) = temp1(ntr+1:datasize, 1);

% a = zeros(ntr,1);
% b = zeros(datasize-ntr,1);

% for i =1:ntr
%     a(i) =1;
% end
% 
% for i =1:datasize-ntr
%     b(i) =1;
% end
% 
% traini = horzcat(a,traini);
% testi = horzcat(b,testi);

end

