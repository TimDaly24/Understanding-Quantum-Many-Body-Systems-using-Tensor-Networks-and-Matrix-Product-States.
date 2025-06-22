
using LinearAlgebra

# Calculate the tensor product of two matrices manually
function tensor_product(A, B)
    m, n = size(A)
    p, q = size(B)
    C = zeros(m * p, n * q)
    for i = 1:m
        for j = 1:n
            C[(i-1)*p+1:i*p, (j-1)*q+1:j*q] = A[i, j] * B
        end
    end
    return C
end
# Verify it against the Kronecker function
pauli_x=[0.0 1.0;1.0 0.0]
var=pauli_x⊗pauli_x
ans=tensor_product(pauli_x,pauli_x)
ans == var # Is true 



 



