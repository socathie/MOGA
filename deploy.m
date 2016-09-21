function [pop_MAnew,pop_MBnew] = deploy(pop_MA,pop_MB,eval_A,eval_B)

%[pop_MAnew,pop_MBnew] = exchange(pop_MA,pop_MB)
%input: ranked subpopuhation matrces ready for exchange pop_MA & pop_MB,
%the fitness distribution eval_A & eval_B
%output: new unranked subpopuhation matrices pop_MAnew & pop_MBnew

[nA,L] = size(pop_MA); %to obtain the size of each subpopulation
[nB,L] = size(pop_MB);

N = nA+nB; %total population size
ratio = eval_A(1)/eval_B(1);

if ratio > 1
    n = round(N/(1+ratio)); %A>B, the size of smaller population
else
    n = round(N/(1+1/ratio)); %B>A
end


if ratio > 1 %A>B sizeA=N-n sizeB=n
    if n < 1
        pop_MBnew = pop_MB(1,:);
        pop_MAnew = pop_MA;
        pop_MAnew((nA+1):(N-1),1) = 0;
        pop_MAnew((nA+1):(N-1),2:L) = binary_gen((N-1-nA),(L-1));
    elseif n > nB %add n-nB chromosomes to B
        pop_MBnew = pop_MB;
        pop_MBnew((nB+1):n,1) = 1;
        pop_MBnew((nB+1):n,2:L) = binary_gen((n-nB),(L-1));
        pop_MAnew = pop_MA(1:(N-n),:);
    elseif n > nA %add N-n-nA chromosomes to A
        pop_MAnew = pop_MA;
        pop_MAnew((nA+1):(N-n),1) = 0;
        pop_MAnew((nA+1):(N-n),2:L) = binary_gen((N-n-nA),(L-1));
        pop_MBnew = pop_MB(1:n,:);
    else
        pop_MAnew = pop_MA(1:n,:); %keep the first n chromosomes
        pop_MBnew = pop_MB(1:n,:);
        pop_MAnew((n+1):(N-n),1) = 0;
        pop_MAnew((n+1):(N-n),2:L) = binary_gen((N-2*n),(L-1)); %randomly generated new chromosomes
    end
else %A<B sizeA=n sizeB=N-n
    if n < 1
        pop_MAnew = pop_MA(1,:);
        pop_MBnew = pop_MB;
        pop_MBnew((nA+1):(N-1),1) = 1;
        pop_MBnew((nA+1):(N-1),2:L) = binary_gen((N-1-nA),(L-1));
    elseif n > nB
        pop_MBnew = pop_MB;
        pop_MBnew((nB+1):(N-n),1) = 1;
        pop_MBnew((nB+1):(N-n),2:L) = binary_gen((N-n-nB),(L-1));
        pop_MAnew = pop_MA(1:n,:);
    elseif n > nA
        pop_MAnew = pop_MA;
        pop_MAnew((nA+1):n,1) = 0;
        pop_MAnew((nA+1):n,2:L) = binary_gen((n-nA),(L-1));
        pop_MBnew = pop_MB(1:(N-n),:);
    else
        pop_MAnew = pop_MA(1:n,:);
        pop_MBnew = pop_MB(1:n,:);
        pop_MBnew((n+1):(N-n),1) = 1;
        pop_MBnew((n+1):(N-n),2:L) = binary_gen((N-2*n),(L-1));
    end
end