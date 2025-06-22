using LinearAlgebra,Kronecker
include("Get_matrix.jl")
# Find prob of finding first qubit in state of either 0/1 and which position 

function measure(N,state,operator,s)
    
    eigenvals, eigenvectors = eigen(operator)
 
    proj1 = eigenvectors[:, 1] * eigenvectors[:, 1]'
    proj2 = eigenvectors[:, 2] * eigenvectors[:, 2]'

    proj1=get_matrix(N,"0"*s)
    proj2=get_matrix(N,"1"*s)
    
    # Calculate probabilities of measuring eigenvector states
    prob1 = real(dot(state',(proj1 * state)))
    prob2 = real(dot(state',(proj2 * state)))

    #Determine state
    ran = rand()
    if ran <= prob1
        measurement = eigenvals[1]
    else
        measurement = eigenvals[2]
    end
    #Get state after measurement
    state1=(proj1*state)/(sqrt(prob1))
    state2=(proj2*state)/(sqrt(prob2))
    return prob2, prob1,eigenvals[2],eigenvals[1],measurement,state1,state2
    
end