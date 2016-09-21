function pop_M = binary_gen(N,L)

%pop_M = binary_gen(N,L)
%input: number of chromosomes N and number of loci L
%output: population matrix pop_M

pop_M = randi([0,1],N,L); %generate a binary population matrix