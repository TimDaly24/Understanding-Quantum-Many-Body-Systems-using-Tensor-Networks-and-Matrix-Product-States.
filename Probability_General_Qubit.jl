using Kronecker,LinearAlgebra
x = [0 1; 1 0]
y = [0 -im; im 0]
z = [1 0; 0 -1]
i = [1 0; 0 1]
mat=Dict('0'=>[1, 0],'1'=>[0,1])

# Function to generate state vector 
function get_state(coefficients)
    n = convert(ComplexF64, log2(length(coefficients)))
    return normalize(vec(coefficients))
end
function get_proj(x)
    proj1=(x*transpose(x))
    return proj1
end

function get_matrix(N,s)
    
    len=length(s)
    mat=Dict('x'=>[0 1;1 0],'y'=>[0 -im;im 0],'z'=>[1 0;0 -1],'h'=>[1/(sqrt(2)) 1/(sqrt(2));1/(sqrt(2)) -1/(sqrt(2))],'0'=>[1 0;0 0],'1'=>[0 0;0 1])
    # Create an empty vector to store the matrices
    matrix_vector = Vector{Matrix}(undef, N)

    # Fill it with identity matrices
    for i in 1:N
    matrix_vector[i] =[1 0;0 1]
    end
    
    for i in 1:3:len
        pos=parse(Int64,s[i+1:i+2])
        matrix_vector[pos]=mat[s[i]]
    end
    
    # Perform the tensor product on each matrix
    result = matrix_vector[1]  
    for i in 2:N
        result = kron(result, matrix_vector[i])
    end

    return result
end 

function measure(qubits,state,s)
    middle=get_matrix(qubits,s)
    conjugate=conj(state)
    prob1 = real(dot(conjugate',(middle* state)))
    return middle 
    
end

state = [1/(sqrt(2)),0,0,1/(sqrt(2))] 
ans = get_state(state)
# Find prob of finding first qubit in state of either 0/1 and which position 

measure(2,ans,"001")

