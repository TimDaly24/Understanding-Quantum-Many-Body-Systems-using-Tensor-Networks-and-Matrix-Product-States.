include("Get_matrix.jl")
function get_ham(N,h1,h2,h3,j1,j2,j3)
    mat1=0*LinearAlgebra.I
    mat2=0*LinearAlgebra.I
    
    for i in 1:N
        if i<10
            r="0"*string(i)
        else
            r=string(i)
        end
        mat1=mat1+(h1*(get_matrix(N,"x"*r)))+(h2*(get_matrix(N,"y"*r)))+(h3*(get_matrix(N,"z"*r)))
    end

    for i in 1:N-1
        if i<10
            r="0"*string(i)
        else
            r=string(i)
        end
        if i<9
            s="0"*string(i+1)
        else
            s=string(i+1)
        end
        
        mat2=mat2+(j1*(get_matrix(N,"x"*r*"x"*s)))+(j2*(get_matrix(N,"y"*r*"y"*s)))+(j3*(get_matrix(N,"z"*r*"z"*s)))
        
    end
    return mat1+mat2
    
end

