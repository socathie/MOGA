function [eval,pop_Mrank] = eval_and_rank(pop_M)

%[eval,pop_Mrank] = eval_and_rank(pop_M)
%input: population matrix pop_M
%output: fitness distribution eval, ranked population matrix pop_Mrank

[N,L] = size(pop_M);

for i = 1:N
    x_base10 = bi2de(pop_M(i,:),'left-msb'); %convert chromosomes to base10
    
    %Ackley
    x = -32 + x_base10*64/(2^L-1);
    eval_tmp(i) = 20+exp(1)-20*exp(-0.2*sqrt(x^2))-exp(cos(2*pi*x));
    
    %Rastrigin
    %x = -5 + x_base10*10/(2^L-1);
    %eval_tmp(i) = x^2 - 10*cos(2*pi*x) + 10;
    
    %Rosenbrock
    %x = -2 + x_base10*4/(2^L-1);
    %eval_tmp(i) = 100*(x-x^2)^2 + (x-1)^2;
    
    %Schwefel
    %x = -500 + x_base10*1000/(2^L-1);
    %eval_tmp(i) = 418.9829101-x*sin(sqrt(abs(x)));

    %if i==1
        %display(x);
    %end
end

for i = 1:N %ranking them in order of descending fitness
    [C,I] = min(eval_tmp);
    
    pop_Mrank(i,:) = pop_M(I,:);
    eval(i) = eval_tmp(I);
    
    eval_tmp(I) = 10000;
end
