

function get_cnot(s)
    zero =[1, 0]
    one= [0, 1]
    cnot =[1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0]
    
    if s[1]=='0'
            res1=zero
    else
            res1=one
    end
    if s[2]=='0'
        res2=zero
    else
        res2=one
    end

    initial=kron(res1,res2)
    return (cnot * initial)
end


display(get_cnot("10"))