function [ err ] = meansquarederr(age, yt , q)

 err=0;
 for i=1:q
     err = err + (age(i) - yt(i))^2;
 end
 err = err/(2*q);

end

