using ITensors
using Plots,Plotly
using PlotlyJS
ITensors.op(::OpName"Sx",::SiteType"S=1") =[0 1;1 0]
function h2(N,hx,hy,hz,jx,jy,jz)
    
    sites = siteinds("S=1",N)

    os = OpSum()
    #Creates the Hamiltonian 
    for j=1:N
        os += hx,"Sx",j
        os += hy,"Sy",j
        os += hz,"Sz",j
    end
    for j=1:N-1
        os += jx,"Sx",j,"Sx",j+1
        os += jy,"Sy",j,"Sy",j+1
        os += jz,"Sz",j,"Sz",j+1
    end
    #Creates an MPO 
    H = MPO(os,sites)

    psi0 = randomMPS(sites,10)

    nsweeps = 10
    maxdim = [3]
    cutoff = [1E-10]
    energy, psi = dmrg(H,psi0; nsweeps, maxdim, cutoff)
    
    
    return energy,psi,H,sites
end
energy,psi,H,sites=h2(11,0,0,1,2,1,0)

#Expectation Value for MPO operator 
expect2=inner(psi',H,psi)
#Expectation value for local operator
expect1=expect(psi,"Sz")


#= Correlation plot
function plot_correlation(corr)
    N = size(corr, 1)
    corr_real = real.(corr)

    plot(1:N, 1:N, corr_real, c=:blues, xlabel="Site Index", ylabel="Site Index", title="Correlation Function")
end

corr=correlation_matrix(psi,"S+","S+")
plot_correlation(corr)
savefig("C:/Users/timst/OneDrive/Documents/SPUR Project/Images/Correlation(S+,S+).png")=#




#=Expectation value vs. Site index
site_index = 1:length(expect1)
plot(site_index, expect1, marker=:square, xlabel="Site Index", ylabel="Expectation Value (Sz)", label="Sz Expectation")
=#


correlations = []
for i in 0:0.2:2
    hz=i
    energy,psi,H,sites=h2(11,0,0,hz,-2,-1,0)
    #mid=Int64(N/2)
    #=if i == maxdim
        continue  
    end=#
    corr = correlation_matrix(psi, "Sx","Sx")
    push!(correlations,corr[2,1])
end

#plot(correlations,legend=false)





