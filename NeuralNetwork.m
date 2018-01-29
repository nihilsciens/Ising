clear all
clc
%% Forward propagation %%

w1 = [0.4 0.5];
w2 = [0.3 0.6];
for i =1:1000
    in = randi(3);
input = in-2;
if input == 0;
target_out = 0;
else
    target_out = 1;
end
Layer_sum1 =    [input.*w1];

Layer_sigmoid1=  [sigmoid(Layer_sum1(1)),sigmoid(Layer_sum1(2))];

Layer_out1 = w2.*Layer_sigmoid1;

calc_out = sigmoid(sum(Layer_out1));

output_error = target_out - calc_out;

delta_out = sigmoid(calc_out)*(1-sigmoid(calc_out))*output_error;

delta_w2 = delta_out./Layer_sigmoid1;

w2 = w2 + delta_w2;

delta_w1 = delta_out./w2.*[sigmoidprime(Layer_sum1(1)), ...
    sigmoidprime(Layer_sum1(2))];

w1 = w1 + delta_w1;
WEIGHT(i) = output_error;
end


%%%% TEST %%%%


for j = 1:100
test_in = 1;
Layer_sum1 =    [test_in.*w1];

Layer_sigmoid1=  [sigmoid(Layer_sum1(1)),sigmoid(Layer_sum1(2))];

Layer_out1 = w2.*Layer_sigmoid1;

calc_out = sigmoid(sum(Layer_out1));
end
