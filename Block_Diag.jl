using LinearAlgebra,BlockDiagonals

include("Get_C_Matrix.jl")
include("Get_matrix.jl")
include("Binary_Decimal_convert.jl")
include("Get_Hamiltonian.jl")
include("Block_Diagonalise_Matrix.jl")
include("Get_C_Hamiltonian.jl")
include("Bogoliubov_Generator.jl")

#Returns the individual blocks of the diagonalised matrix
function get_Blocks(H,pairs)
    k=length(H)
    h2=[]
    for i in 1:length(pairs)
            p=pairs[i]
            push!(h2,H[p,p])   
    end
    return h2
end



# Declare Number of sites
N=6
hx=0
hy=0
hz=.1
jx=1
jy=.9
jz=0
# Get the Hamiltonian from the original code
not_c=get_ham(N,hx,hy,hz,jx,jy,jz)
not_c=Matrix(not_c)

# Compare it the to the Hamiltonian from the C-code
#=c=get_C_ham(N,hz,jx,jy,jz)
c=Int64.(c)=#

# Get the Hbdg matrix
hbdg=get_hbdg(N,hz,jx,jy)
hbdg=Matrix(hbdg)


#Diagonalise the two matrices and return the pairs
Is1,pairs1=get_diag(2^N,not_c)
Is2,pairs2=get_diag(2^N,c)

# Create the block diagonal matrix 
H01=sparse(not_c[Is1,Is1])
H02=sparse(c[Is2,Is2])

ans=(get_Blocks(not_c,pairs1))

eig1=eigvals(not_c)
eig2=eigvals(hbdg)
a2=filter(x -> x > 0, eig2)
E1=minimum(eig1)
En=0
for i in 1:length(a2)
    global En=En+(a2[i]/2)
end
display(-En)
display(eig2)
display(a2)
#-En+a2[2]