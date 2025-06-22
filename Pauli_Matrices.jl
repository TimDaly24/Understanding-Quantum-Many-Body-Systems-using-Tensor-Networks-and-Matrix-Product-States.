using Kronecker
using LinearAlgebra,SparseArrays

function get_matrix(N,s)
    
    len=length(s)
    mat=Dict('x'=>sparse([0 1;1 0]),'y'=>sparse([0 -im;im 0]),'z'=>sparse([1 0;0 -1]),'h'=>sparse([1/(sqrt(2)) 1/(sqrt(2));1/(sqrt(2)) -1/(sqrt(2))]))
    # Create an empty vector to store the matrices
    matrix_vector = Vector{Matrix}(undef, N)

    # Fill it with identity matrices
    for i in 1:N
    matrix_vector[i] =sparse([1 0;0 1])
    end
    
    # Insert neccessary values into vector 
    for i in 1:3:len
        pos=parse(Int64,s[i+1:i+2])
        matrix_vector[pos]=sparse(mat[s[i]])
    end

    # Perform the tensor product on each matrix
    result = matrix_vector[1]  
    for i in 2:N
        result = kron(sparse(result), sparse(matrix_vector[i]))
    end

    return result
end 


function c_not(A,B,N)
    a=string(A)
    b=string(B)
    H=get_matrix(N,"h0"*b)
    i= Matrix{Float64}(I,N,N)
    val1="z0"*a
    val2="z0"*b
    val3="z0"*a*"z0"*b
    M=(LinearAlgebra.I+get_matrix(N,val1)+get_matrix(N,val2)-get_matrix(N,val3))
    return ((H*M/2)*H)

end

ans=get_matrix(11,"x10z11")
ans=Matrix(ans)