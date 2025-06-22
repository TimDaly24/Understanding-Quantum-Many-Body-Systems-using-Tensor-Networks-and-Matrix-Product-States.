# Simple probability with no operators(one qubit)

using Kronecker
using LinearAlgebra

zero=[1;0]
one=[0;1]
plus=[1/(sqrt2);1/(sqrt2)]
minus=[1/(sqrt2);-1/(sqrt2)]

function get_proj(x)
    proj1=(x*transpose(x))
    return proj1
end

function get_prob(w,x,y,z)
    proj1=get_proj(x)
    proj2=get_proj(z)
    vec1=(w*x)+(y*z)
    vec2=transpose(vec1)
    return [dot(vec2,(proj1*vec1)),dot(vec2,(proj2*vec1))]
    
end

function get_state(w,x,y,z)
    ans=get_prob(w,x,y,z)
    ran=rand(0:1)
    prob1=ans[1]
    prob2=ans[2]
    big=max(prob1,prob2)
    if ran<big
        println("State:|$x>")
    else
        println("State:|$z>")
    end
end

get_prob(1/sqrt(3),zero,sqrt(2/3),one)



