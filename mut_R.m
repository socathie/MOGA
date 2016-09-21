function pop_M = mut_R(pop_M)

%pop_Mnew = mut_R(pop_M)
%input: ranked population matrix pop_M
%output: mutated by row population matrix pop_Mnew

[N,L] = size(pop_M);
[mut_M,a,b] = mutation_matrix(pop_M);

for i = 1:N
    r_i = rand; %assign random number
    if r_i<a(i)
        k = a(i)*L; %determine how many bits to mutate
        b_tmp = b;
        for j = 1:round(k)
            [value, index] = max(b_tmp); %change the largest b first
            if pop_M(i,index)==0
                pop_M(i,index) = 1;
            else
                pop_M(i,index) = 0;
            end
            b_tmp(index) = 0;
        end
    end
end