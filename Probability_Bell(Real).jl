using Kronecker,LinearAlgebra
include("Bell_States1.jl")
include("Get_matrix.jl")
include("Measurement.jl")
x = [0 1; 1 0]
y = [0 -im; im 0]
z = [1 0; 0 -1]
i = [1 0; 0 1]
cnot =[1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0]
H=[1/(sqrt(2)) 1/(sqrt(2));1/(sqrt(2)) -1/(sqrt(2))]
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


function get_ket(state)
    basis=Dict("|00>"=>[1.0 ;0.0;0.0; 0.0],"|01>"=>[0.0 ;1.0;0.0; 0.0],"|10>"=>[0.0 ;0.0;1.0; 0.0],"|11>"=>[0.0 ;0.0;0.0; 1.0])
    if state==basis["|00>"]
        state="|00>"
    elseif state==basis["|01>"]
        state="|01>"
    elseif state==basis["|10>"]
        state="|10>"
    else 
        state="|11>"
    end
    return state
end

state=get_bell([0 1])
ans = get_state(state)


p1, p2,s1,s2,measurement,state1,state2 = measure(2,ans, z,"01")  
state1=get_ket(state1)
state2=get_ket(state2)
if measurement == s1
    measurement=state1
else 
    measurement=state2
end

println("Probability of measuring: "*state1 ,": ", p1)
println("Probability of measuring: "*state2 ,": ", p2)
println("Measurement outcome: "* measurement)
println("State 1: "*state1 )
println("State 2: "*state2 )


