using LinearAlgebra
mat=Dict('x'=>[0 1;1 0],'y'=>[0 -im;im 0],'z'=>[1 0;0 -1],'u'=>1.26e-6,'2'=>2,'3'=>3,'4'=>4,'5'=>5,'6'=>6,'7'=>7,'8'=>8,'9'=>9)
function get_matrix(terms)
    len=length(terms)
    nums=[]
    constants=[]
    res=[0 0;0 0]
    for i in 1:len
        len2=length(terms[i])
        
        for j in 1:len2 
            if j>1&& terms[i][j-1]=='*'
                continue
            end
            if terms[i][j-1]=='('
            
            
                if terms[i][j]=='*'
                nums[end]=(nums[end]*(mat[terms[i][j+1]]))
                continue
            end
            for j in 1:len2 
                if j>1&& terms[i][j-1]=='/'
                    continue
                end
                
                if terms[i][j]=='/'
                    nums[end]=(nums[end]/(mat[terms[i][j+1]]))
                    continue
                end
            end
            if haskey(mat,terms[i][j])
                push!(nums,mat[terms[i][j]])
            else 
                push!(constants,terms[i][j])
            end
        end
    end
    for i in 1:length(nums)
        if constants[i]=='+'
            res=res+nums[i]
        else
            res=res-nums[i]
        end
    end
    return res

end

function find_ground_state(H)
    eigenvals, eigenvecs = eigen(H)
    index = argmin(eigenvals)
    eigenvec = eigenvecs[:, index]
    energy = eigenvals[index]
    return energy,eigenvec
end

function factor(matrix,constant) 
    rows, cols = size(matrix)
    result = similar(matrix, rows, cols)
    
    for i in 1:rows
        for j in 1:cols
            result[i, j] = matrix[i, j] / constant
        end
    end
    
    return result
end

# Define your Hamiltonian as a string here
hamiltonian_str = "+u*2*x, +u*z"

# Remove spaces and split the Hamiltonian string into terms
hamiltonian_str = replace(hamiltonian_str, " " => "")
hamiltonian_terms = split(hamiltonian_str, ",")
hamiltonian_terms=collect(hamiltonian_terms)

#Construct the Hamiltonian matrix
res=factor(get_matrix(hamiltonian_terms),mat['u'])

energy, state_eigenvec = find_ground_state(res)

println("Factor: ",mat['u'])
display(res)
println("Ground state energy: ", energy)
println("Ground state eigenvector: ",state_eigenvec)

