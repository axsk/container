clear all; 

%  num1 -> sum -> sumsquared -> mix
%  num2 /      \-------------/ 

num1 = Container(1)
num2 = Container(2)

sum = Container(@(x,y) x+y, num1, num2)
sumsquared = Container(@(x) x^2, sum)
mix = Container(@(x,y) x*y, sum, sumsquared)

num1.value == 1
num2.value == 2
sum.value == 3

num1.value = 5
num1.value == 5
sum.value == 7

sumsquared.value == 49
mix.value == 49 * 7