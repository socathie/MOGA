function gen = MOGAC(N,L,e)

%MOGAC(N,L,e)
%input: population size N, number of loci L,stopping criterion e

pop_M = binary_gen(N,L);

gen = 1;

[eval,pop_M] = eval_and_rank(pop_M);

while eval(1) > e
    gen = gen+1;
    pop_M = mut_C(pop_M);
    [eval,pop_M] = eval_and_rank(pop_M);
    %display(gen);
    %display(eval(1));
end