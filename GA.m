function gen = GA(N,L,p_c,p_m,e)

%GA(N,L,p_c,p_m,e)
%input: population size N, number of loci L, crossover probability p_c,
%mutation probability p_m

pop_M = binary_gen(N,L);

gen = 1;

[eval,pop_M] = eval_and_rank(pop_M);

while eval(1) > e
    gen = gen+1;
    pop_M = crossover(pop_M,p_c);
    pop_M = mut(pop_M,p_m);
    [eval,pop_M] = eval_and_rank(pop_M);
    %display(gen);
    %display(eval(1));
end