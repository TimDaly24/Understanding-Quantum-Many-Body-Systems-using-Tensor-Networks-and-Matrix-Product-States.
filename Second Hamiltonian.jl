using LinearAlgebra,Kronecker,Plots,SparseArrays
include("Get_Hamiltonian.jl")
include("Get_matrix.jl")
#include("Itensor 1.jl")
x = [0 1; 1 0]
y = [0 -im; im 0]
z = [1 0; 0 -1]
i = [1 0; 0 1]
cnot =[1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0]
H=[1/(sqrt(2)) 1/(sqrt(2));1/(sqrt(2)) -1/(sqrt(2))]
mat=Dict('0'=>[1, 0],'1'=>[0,1])



function calculate_ground_state(H)
    eigenvals, eigenvecs = eigen(H)
    return eigenvals
end

function get_difference(eigenvals)
    len=length(eigenvals)
    result=zeros(len-1,1)
    for i in 1:len
        first_value = eigenvals[i]
        rest_values = eigenvals[1:end]
        rest_values = vcat(rest_values[1:i-1], rest_values[i+1:end])
        rest_values=reverse(rest_values)
        differences= rest_values .- first_value
        result=hcat(result,differences)
    end
    result=abs.(result)
    result = result[:, 2:end]
    return result
end

N=7
hx=0
hy=0
jx=1
jy=0.2
jz=0
mateig=[]

start=0
step=0.002
stop=2
range=start:step:stop
for i in range
    count=1
    local hz=i
    local res1=get_ham(N,hx,hy,hz,jx,jy,jz)
    res1=Matrix(res1)
    local eigenvals = calculate_ground_state(res1)
    #eigenvals=real(eigenvals)
    local min1=minimum(eigenvals)
    eigenvals=eigenvals.-min1
    push!(mateig,eigenvals)
    
end

len=length(mateig)
count=0

for i in 1:len
   global count
   
   if count==0
    x1 = fill(count, length(mateig[i]))
   scatter(x1,mateig[i],marker = :circle, markersize = 1,legend=false,)
   else
    x1 = fill(count, length(mateig[i]))
   scatter!(x1,mateig[i],marker = :circle, markersize = 1,legend=false,)
   end
   
    xlabel!("h_z")
    ylabel!("E-E0")
    ylims!(0, 6)
   count +=step
end

savefig("plot.pdf")
savefig("C:/Users/timst/OneDrive/Documents/SPUR Project/Images/plot_power.pdf")