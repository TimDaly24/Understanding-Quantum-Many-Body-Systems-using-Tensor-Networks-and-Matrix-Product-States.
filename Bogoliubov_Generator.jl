using LinearAlgebra,Kronecker,SparseArrays

include("Get_C_Matrix.jl")

function get_hbdg(N,hz,jx,jy)
    t=(jx+jy)
    u=-2*hz
    d=(jx-jy)
    mat1=zeros(N,N)
    mat2=zeros(N,N)

    for i in 1:N
        for j in 1:N
            if i==j
                mat1[i,j]=u
                
            elseif i-j==-1
                mat1[i,j]=-t
                mat2[i,j]=d
            elseif i-j==1
                mat1[i,j]=-t
                mat2[i,j]=-d
            end
        end
    end
    mat3=-(mat1')
    mat4=mat2'
    matfin=vcat((hcat(mat1,mat2)),(hcat(mat4,mat3)))
    
    return sparse(matfin)
end


get_hbdg(5,2,1,2)

