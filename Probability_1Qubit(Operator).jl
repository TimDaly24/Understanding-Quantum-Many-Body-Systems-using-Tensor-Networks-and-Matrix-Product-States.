using LinearAlgebra, Kronecker
x = [0 1; 1 0]
y = [0 -im; im 0]
z = [1 0; 0 -1]

function get_measurement(proj1,proj2,prob1,prob2,state)
    state1=(proj1*state)/(sqrt(prob1))
    state2=(proj2*state)/(sqrt(prob2))
    return state1,state2
end


function measure(state,operator)
    
    eigenvals, eigenvectors = eigen(operator)
    
    # Calculate projection operators
    proj1 = eigenvectors[:, 1] * eigenvectors[:, 1]'
    proj2 = eigenvectors[:, 2] * eigenvectors[:, 2]'
    
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

state = [sqrt(3)/2, 1/2]  
p1, p2,s1,s2,measurement,state1,state2 = measure(state, x)  

println("Probability of measuring ($s1): ", p1)
println("Probability of measuring ($s2): ", p2)
println("Measurement outcome: ", measurement)
println("State1: $state1" )
println("State1: $state2" )


