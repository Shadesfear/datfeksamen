function [outputArg] = variation(number,variationPercent)
%Returner numberet med en variation givet i decimal tal

a = -variationPercent/100;
b = variationPercent/100;
outputArg = number+number*(a + (-a+b)*rand);
end

