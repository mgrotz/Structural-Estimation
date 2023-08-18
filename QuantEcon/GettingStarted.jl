using Plots
plot(sin, -2π, 2π, label = "sin(x)")

using LinearAlgebra
x = [1, 2]
y = [3,4]

@show dot(x,y)


######################################################################
################# 2. INTRODUCTORY EXAMPLES ###########################
######################################################################

using LinearAlgebra, Statistics, Plots, LaTeXStrings

n = 100
ϵ = randn(n)
plot(1:n, ϵ)

typeof(ϵ)

ϵ[1:10]

n = 100
ϵ = zeros(n)
for i in 1:n
    ϵ[i] = randn()
end

# better style
n = 100
ϵ = zeros(n)
for i in eachindex(ϵ)
    ϵ[i] = randn()
end

# BROADCASTING
function generatedata(n)
    ϵ = randn(n) # use built in function
    return ϵ .^ 2
end
data = generatedata(5)

generatedata(n) = randn(n) .^ 2

using Distributions

######################################################################
###################### FIXED POINT THEOREM ###########################
######################################################################

