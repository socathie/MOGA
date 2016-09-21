function v = mut(v,p_m)

[N,L] = size(v);

m = rand(N,L);
    
    for i = 1:N
        for j = 1:L
            if m(i,j)<p_m %mutate the bit
                if v(i,j)==0 %if zero, then change to one
                    v(i,j)=1;
                else
                v(i,j)=0; %else, make it zero
                end
            end
        end
    end