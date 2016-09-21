function gen = MOGAX(N,L,e)

%MOGAX(N,L)
%input: population size N, number of loci L,stopping criterion e

n = N/2;

pop_MA(1:n,1) = 0;
pop_MB(1:n,1) = 1;
pop_MA(1:n,2:L) = binary_gen(n,(L-1));
pop_MB(1:n,2:L) = binary_gen(n,(L-1));

gen = 1;

[eval_A,pop_MA] = eval_and_rank(pop_MA);
[eval_B,pop_MB] = eval_and_rank(pop_MB);

%display(gen);
%display(eval_A(1));
%display(eval_B(1));

con_A = [-10000 eval_A(1)]; %save top fitness
con_B = [-10000 eval_B(1)];

while eval_A(1)>e && eval_B(1)>e
%while eval_A(1) < (2.85-e) && eval_B(1) < (2.85-e)
    
    con_A(1) = con_A(end);
    con_B(1) = con_B(end);
    con_A(end) = eval_A(1);
    con_B(end) = eval_B(1);
    
    gen = gen+1;
    
    if con_A(1) == con_A(2) || con_B(1) == con_B(2) %exchange condition met
        gen = gen+1;
        
        [pop_MA,pop_MB] = deploy(pop_MA,pop_MB,eval_A,eval_B);
        [eval_A,pop_MA] = eval_and_rank(pop_MA);
        [eval_B,pop_MB] = eval_and_rank(pop_MB);
        %display('exchanged');
    end
    
    if size(pop_MA)>size(pop_MB); %note the mutation method used
        pop_MA = mut_C(pop_MA);
        pop_MB = mut_R(pop_MB);
    else
        pop_MA = mut_R(pop_MA);
        pop_MB = mut_C(pop_MB);
    end
    
    [eval_A,pop_MA] = eval_and_rank(pop_MA);
    [eval_B,pop_MB] = eval_and_rank(pop_MB);
    %display('mutated');
    
   %display(gen);
   %display(eval_A(1));
   %display(eval_B(1));
end