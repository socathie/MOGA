function pop_Mnew = mut_C(pop_M)

%pop_Mnew = mut_C(pop_M)
%input: ranked population matrix pop_M
%output: mutated by column population matrix pop_Mnew

[N,L] = size(pop_M);
[mut_M,a,b] = mutation_matrix(pop_M);

pop_Mnew = pop_M;

for j = 1:L
    r_j = rand; %assign random number
    if r_j<b(j)
        w = b(j)*N; %determine how many bits to mutate
        for i = (N-round(w)+1):N %mutate from the bottom
            if pop_M(i,j)==0
                pop_Mnew(i,j) = 1;
            else
                pop_Mnew(i,j) = 0;
            end
        end
    end
end