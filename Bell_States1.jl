using Kronecker
using LinearAlgebra
    

s=[1 1]
z =[1;0]
o= [0;1]
cnot =[1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0]
H=[1/sqrt(2) 1/sqrt(2);1/sqrt(2) -1/sqrt(2)]
i=[1 0;0 1]
    
if s[1]==0
            res1=z
else
            res1=o
end
if s[2]==0
        res2=z
else
        res2=o
end
# Apply Tensor product
num=cnot*(kron(H,i)*kron(res1,res2))
    

