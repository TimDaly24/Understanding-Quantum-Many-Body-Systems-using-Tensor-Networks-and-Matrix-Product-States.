using LinearAlgebra,Kronecker,SparseArrays
function getmat(N, which)
    
    sx = sparse([0 1; 1 0])
    sy = sparse([0 -im; im 0])
    sz = sparse( [1 0; 0 -1])
    I = sparse([1 0; 0 1])
    ii = 'I'
    H = sparse(1/sqrt(2) * [1 1; 1 -1])
    operators = fill(ii, N)
    numoperators = length(which) ÷ 3

    for x = 1:numoperators
        operators[parse(Int, which[3*(x-1) .+ (2:3)])] = which[3*(x-1) + 1]
    end

    println(operators)

    M = 1
    for x = 1:N
        if operators[x] == 'X'
            M = kron(M, sx)
        elseif operators[x] == 'Y'
            M = kron(M, sy)
        elseif operators[x] == 'Z'
            M = kron(M, sz)
        elseif operators[x] == 'I'
            M = kron(M, I)
        elseif operators[x] == 'H'
            M = kron(M, H)
        end
    end
    return M
end

#getmat(2,"X1X2")
i=10
if i<10
    x="0"*string(i)
else
    x=string(i)
end
if i<10
    s="0"*string(i+1)
else
    s=string(i+1)
end
s=((("x"*x*"x"*s)))
pos=parse(Int64,s[4+1:4+2])
#print(pos)
for i in 1:3:10
    println(i)
end