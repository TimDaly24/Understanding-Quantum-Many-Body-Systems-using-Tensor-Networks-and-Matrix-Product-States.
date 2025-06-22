include("Get_matrix.jl")
include("Binary_Decimal_convert.jl")
include("Get_Hamiltonian.jl")
include("Get_C_Hamiltonian.jl")
include("Get_C_Matrix.jl")



function get_diag(N,H)
    H=abs.(H).>0
    len=Int64((size(H,2))/2)
    len1=Int64((size(H,2)))
    basis=Matrix{Int64}(I, len1, len1)
    pairs = []
    vec1=[]
    for i in 1:N
        a=(H^20)
        b=(H^21)
        res1=a+b
        res1=abs.(res1).>0
        ans=res1*basis[:,i]
        if ans==basis[:,i]
            
            push!(vec1,i)
            push!(pairs,[i])
        else 
            indexes = findall(isequal(1), ans)
            if all(indexes .== 0)
                continue
            end
            if indexes[1] in vec1
                continue
            else
                for j in 1:length(indexes)
                push!(vec1,indexes[j])
                end 
                push!(pairs,indexes)
            end
            
        end
        res1=0*res1
    end
    
    return vec1,pairs
end 

get_diag(4,[2 0 0 0;0 0 0 0;0 0 0 0;0 0 0 6])
