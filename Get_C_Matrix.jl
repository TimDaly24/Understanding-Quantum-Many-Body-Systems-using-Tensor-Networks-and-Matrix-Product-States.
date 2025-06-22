using LinearAlgebra,SparseArrays,Kronecker

function get_C_matrix(N,s)
    
    len=length(s)
    maxint=[]
    mat=Dict('x'=>sparse([0 1;1 0]),'y'=>sparse([0 -im;im 0]),'z'=>sparse([1 0;0 -1]),'h'=>sparse([1/(sqrt(2)) 1/(sqrt(2));1/(sqrt(2)) -1/(sqrt(2))]),'n'=>([0 0;0 1]),'C'=>([0 0;1 0]),'c'=>([0 1;0 0]))
    # Create an empty vector to store the matrices
    matrix_vector = Vector{Matrix}(undef, N)

    # Fill it with identity matrices
    for i in 1:N
    matrix_vector[i] =(mat['z'])
    end
    
    # Insert neccessary values into vector 
    for i in 1:3:len
        pos=parse(Int64,s[i+1:i+2])
        push!(maxint,pos)
        matrix_vector[pos]=((mat[s[i]]))
    end
    max=maximum(maxint)
    ab=Int64(len/3)
    #Fill end wise with identities

    for i in max+1:N
        matrix_vector[i]=[1 0;0 1]
    end
    # Perform the tensor product on each matrix
    result = matrix_vector[1]  
    for i in 2:N
        result = kron((result), (matrix_vector[i]))
    end
    return result
end 

get_C_matrix(3,"n03")
