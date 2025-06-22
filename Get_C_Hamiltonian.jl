include("Get_C_Matrix.jl")
function get_N(s)
    if parse(Int64,(s[2:3]))<10
        r="0"*string(s[3])
    else
        r=string(s[2:3])
    end
    n=get_C_matrix(N,"C"*r)*get_C_matrix(N,"c"*r)
    return n
end

function get_C_ham(N,hz,j1,j2,j3)
    mat1=0*LinearAlgebra.I
    mat2=0*LinearAlgebra.I
    l=Matrix{Int64}(I, 2^N, 2^N)
    
    for i in 1:N
        if i<10
            r="0"*string(i)
        else
            r=string(i)
        end
        n=get_N("n"*r)
        
        a2=-(1/2)*l
        mat1=mat1-(2*hz*(n+a2))
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
        a1=(-(j1+j2)*((get_C_matrix(N,"C"*r*"c"*s))+(get_C_matrix(N,"C"*s*"c"*r))))
        a2=(4*j3*(get_C_matrix(N,"n"*r*"n"*s)))
        a3=(2*j3*((get_N("n"*r))+get_N("n"*s)))
        mat2=mat2+a1+a2+a3
        
    end
    return  mat1+mat2
    
end


