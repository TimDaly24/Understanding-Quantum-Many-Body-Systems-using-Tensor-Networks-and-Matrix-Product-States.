#decimal to binary
function dec2bin(x::Int64,N::Int64)
    s = ""
    while x > 0
        if x % 2 == 0
            s =  "0" * s
        else
            s =  "1" * s
        end
        x = div(x, 2)
    end
    return lpad(s, N, "0")
end


#binary to decimal
function bin2dec(x::String)
    n = length(x)
    y = 0
    for i = 1:n
        y += parse(Int64, x[i]) * 2^(n-i)
    end
    return y
end