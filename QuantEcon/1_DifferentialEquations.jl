using LinearAlgebra, Statistics, Plots, LaTeXStrings
A = [1 -1; 1 0]

function diffeq(A, x_0, maxiter, res)
    x_v = convert(Array{Float64}, x_0)
    x = [x_v[1]]
    y = [x_v[2]]
    z = [0]
    iter = 1
    while iter <= maxiter
        x_v = A*x_v*res+x_v
        push!(x, x_v[1])
        push!(y, x_v[2])
        iter = iter+1
        push!(z, iter)
    end
    return (x,y, z)  
end

diffeq(A, [.1;.1], 2, 1)

plot(diffeq(A, [-.01;0], 200, .2))
plot!(diffeq(A, [.01;0], 200, .2))
plot!(diffeq(A, [0;.01], 200, .2))
plot!(diffeq(A, [0;-.01], 200, .2))



eigvecs(A)