using LinearAlgebra,SparseArrays,Kronecker
function get_matrix(N,s)
    
    len=length(s)
    mat=Dict('x'=>sparse([0 1;1 0]),'y'=>sparse([0 -im;im 0]),'z'=>sparse([1 0;0 -1]),'h'=>[1/(sqrt(2)) 1/(sqrt(2));1/(sqrt(2)) -1/(sqrt(2))])
    # Create an empty vector to store the matrices
    matrix_vector = Vector{Matrix}(undef, N)

    # Fill it with identity matrices
    for i in 1:N
    matrix_vector[i] =([1 0;0 1])
    end
    
    # Insert neccessary values into vector 
    for i in 1:3:len
        pos=parse(Int64,s[i+1:i+2])
        matrix_vector[pos]=(sparse(mat[s[i]]))
    end

    # Perform the tensor product on each matrix
    result = matrix_vector[1]  
    for i in 2:N
        result = kron(sparse(result), sparse(matrix_vector[i]))
    end
    return result
end 

get_matrix(2,"x01x02")