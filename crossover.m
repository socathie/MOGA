function pop_M = crossover(v,p_c)

[N,L] = size(v);

%%%%%%%%%% crossover %%%%%%%%%%
    
    tmp_matrix = []; %to store the selected chromosome
    c = rand(1,N); %to assign random numbers to each chromosome
    vmatrix_tmp = []; %to store the new v matrix
    
    for i = 1:N
        if c(i)<p_c %selecting chromosomes for crossover
            tmp_matrix = [tmp_matrix;v(i,:)]; %putting the selected chromosome into tmp_matrix
        end
    end
    
    [row,dummy] = size(tmp_matrix); %obtaining the number of selected chromosomes
    c_matrix = zeros(row,L); %preparing the crossover selection
    
    if mod(row,2)==0 %if the number of selected chromosomes is even
        
        for j = 1:N
            if c(j)>=p_c %move the unchanged chromosomes to the top of vmatrix_tmp
                vmatrix_tmp = [vmatrix_tmp;v(j,:)];
            end
        end
        
        rand_val = rand(1,row); %assign random values to the selected chromosomes
        
        for j = 1:row
            [dummy,min_index] = min(rand_val); %finding the minimum random value
            c_matrix(j,:) = tmp_matrix(min_index,:); %putting the vectors in ascending order of random values
            rand_val(min_index) = 2; %preventing double count
        end
        
        for j = 1:2:row
            cut_off = randi(L-1); %random cut-off point
            tmp_v = c_matrix(j,:); %temporary vector for crossover
            c_matrix(j,(cut_off+1):L) = c_matrix(j+1,(cut_off+1):L); %crossovering neightbor vectors
            c_matrix(j+1,(cut_off+1):L) = tmp_v((cut_off+1):L);
        end
        
        for j = 1:row
            vmatrix_tmp = [vmatrix_tmp;c_matrix(j,:)]; %putting the changed vectors back to the new v matrix
        end
                
    else %odd, then we need to add or drop one vector
        add_or_drop = rand; %deciding which action to execute
        
        if add_or_drop<0.5 %add
            
            [dummy,add_index] = max(c); %adding the maximum assigned value vector
            tmp_matrix = [tmp_matrix;v(add_index,:)]; %adding the extra vector to the selected set
            
            for j = 1:N
                if ((j ~= add_index)&&(c(j)>=p_c))
                    vmatrix_tmp = [vmatrix_tmp;v(j,:)]; %unchanged chromosomes moved upward
                end
            end
            
            rand_val = rand(1,row+1); %assign random values to selected set
            
            for j = 1:(row+1)
                [dummy,min_index] = min(rand_val); %finding the min rand val
                c_matrix(j,:) = tmp_matrix(min_index,:); %putting in ascending order
                rand_val(min_index) = 2; %prevent double count
            end
            
            for j = 1:2:(row+1)
                cut_off = randi(L-1); %cut-off pt
                tmp_v = c_matrix(j,:); %temp vector
                c_matrix(j,(cut_off+1):L) = c_matrix(j+1,(cut_off+1):L); %crossover
                c_matrix(j+1,(cut_off+1):L) = tmp_v((cut_off+1):L);
            end
            
            for j = 1:(row+1)
                vmatrix_tmp = [vmatrix_tmp;c_matrix(j,:)]; %put into new v
            end
        
        else
            
            [dummy,drop_index] = min(c); %dropping the min vector
            rand_val = rand(1,row);
            
            for j = 1:N
                if ((c(j)>=p_c)||(j == drop_index)) %unchanged and dropped bectors moved upward
                    vmatrix_tmp = [vmatrix_tmp;v(j,:)];
                end
            end
            
            for j = 1:(row-1)
                [dummy,min_index] = min(rand_val);
                c_matrix(j,:) = tmp_matrix(min_index,:);
                rand_val(min_index) = 2; %avoid counting the dropped vector
            end
            
            for j = 1:2:(row-1) %crossing over
                cut_off = randi(L-1);
                tmp_v = c_matrix(j,:);
                c_matrix(j,cut_off+1:L) = c_matrix(j+1,cut_off+1:L);
                c_matrix(j+1,cut_off+1:L) = tmp_v(cut_off+1:L);
            end
            
            for j = 1:(row-1)
                vmatrix_tmp = [vmatrix_tmp;c_matrix(j,:)]; %put back into new v
            end
            
        end
    end
    
    pop_M = vmatrix_tmp;