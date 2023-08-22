using LinearAlgebra, Statistics, Plots, LaTeXStrings

function diffeq_one(f, x_0, maxiter = 1000, res = .001, frame = 10, iter_steps = 50)
    x_v = convert(Array{Float64}, x_0)
    x = [x_v[1]]
    y = [x_v[2]]
    y = convert(Array{Float64}, y)
    z = [0]
    z = convert(Array{Float64}, z)
    iter = 0
    while iter <= maxiter && abs(x_v[1]) <= 10 && abs(x_v[2]) <= 10
        if mod(iter, iter_steps) == 0 && iter != 0
            push!(x, NaN)
            push!(y, NaN)
            push!(z, NaN)
        else
            x_v = f(x_v)*res+x_v
            push!(x, x_v[1])
            push!(y, x_v[2])
            push!(z, iter)
        end
        iter = iter+1
    end

    x_v = convert(Array{Float64}, x_0)
    while iter >= -maxiter && abs(x_v[1]) <= 10 && abs(x_v[2]) <= 10
        if mod(iter, iter_steps) == 0 && iter != 0
            pushfirst!(x, NaN)
            pushfirst!(y, NaN)
            pushfirst!(z, NaN)
        else
            x_v = x_v-f(x_v)*res
            pushfirst!(x, x_v[1])
            pushfirst!(y, x_v[2])
            pushfirst!(z, iter)
        end
        iter = iter-1
    end
    return (x,y,z)  
end


function diffeq_many(f,  x_0, y_0,  maxiter = 10000, res = .001, frame = 10, iter_steps = 500)
    plt = plot(diffeq_one(f, [x_0[1]; y_0[1]], maxiter, res, frame, iter_steps)[1:2], arrow = true)
    for i in range(2, length(x_0))
        plot!(plt, diffeq_one(f, [x_0[i]; y_0[i]], maxiter, res, frame, iter_steps)[1:2], arrow = true)
    end
    return plt
end


diffeq_many(x -> [-2 .5; 2 -2]*x, x_0, y_0)


function lindiffeq_many(A, n,  maxiter = 10000, res = .001, frame = 10, iter_steps = 500)
    x_0 = map(x -> sin(x)*5, range(convert(Float64,0), convert(Float64, 2π), length = n))
    y_0 = map(x -> cos(x)*5, range(convert(Float64,0), convert(Float64, 2π), length = n))
    plt = diffeq_many(x -> A*x,  x_0, y_0,  maxiter, res, frame, iter_steps)
    for i in [1,3] 
        x_range = range(-frame, frame, step = res)
        y_eigen = (eigvecs(A)[i+1]/eigvecs(A)[i]*x_range)
        x_range = x_range[broadcast(abs, y_eigen).<frame]
        y_eigen = y_eigen[broadcast(abs, y_eigen).<frame]
        y_eigen[begin:iter_steps*4:end] .= NaN

        x1_range = x_range[x_range.<0]
        x2_range = x_range[x_range.>0]
        y1_eigen = y_eigen[x_range.<0]
        y2_eigen = y_eigen[x_range.>0] 
        if i == 1
            j = 1
        else
            j = 2
        end    
        
        if eigvals(A)[j] isa Complex
            x1_range = 0
            y1_eigen = 0
            x2_range = 0
            y2_eigen = 0
        elseif eigvals(A)[j] > 0 
            reverse!(x1_range)
            reverse!(y1_eigen)
        else
            reverse!(x2_range)
            reverse!(y2_eigen)
        end

        plot!(plt, x1_range, y1_eigen, arrow = true, linecolor = "grey")
        plot!(plt, x2_range, y2_eigen, arrow = true, linecolor = "grey", legend = false)
    end
    return plt
end



## NICE EXAMPLES

lindiffeq_many([-2 .5; 2 -2],25)
lindiffeq_many([-3 2; -2 2],15)
lindiffeq_many([3 1; -1 1],25)
lindiffeq_many([1 -1; 5 -1],15)
lindiffeq_many([1 -1; 5 -2],10)

