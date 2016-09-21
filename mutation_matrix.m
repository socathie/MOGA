function [mut_M,a,b] = mutation_matrix(pop_M)

%mut_M = mutation_matrix(pop_M)
%input: ranked population matrix pop_M
%output: mutation matrix mut_M

[N,L] = size(pop_M);

p_0(1:L) = 0; %initialize
p_1(1:L) = 0;

for i = 1:N
    a(i) = (i-1)/(N-1); %monotonically increasing function
end

for i = 1:L
    for j = 1:N
        if pop_M(j,i)==0
            p_0(i) = p_0(i) + (N+1-j); %probability of bits with fitness
        else
            p_1(i) = p_1(i) + (N+1-j);
        end
    end
end

p_0 = p_0/(N*(N+1)/2); %normalize
p_1 = p_1/(N*(N+1)/2);
        
for i = 1:L
    b(i) = 1-abs(p_0(i)-0.5)-abs(p_1(i)-0.5); %construct b
end

 for i = 1:N
     for j = 1:L
         mut_M(i,j) = a(i)*b(j); %construct mutation matrix
     end
 end