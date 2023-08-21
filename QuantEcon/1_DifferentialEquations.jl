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

x_0 = map(x -> sin(x)*5, range(convert(Float64,0), convert(Float64, 2π), length = 25))
y_0 = map(x -> cos(x)*5, range(convert(Float64,0), convert(Float64, 2π), length = 25))
diffeq_many(x -> [-2 .5; 2 -2]*x, x_0, y_0)


function lindiffeq_many(A, x_0, y_0,  maxiter = 10000, res = .001, frame = 10, iter_steps = 500)
    plt = diffeq_many(x -> A*x,  x_0, y_0,  maxiter, res, frame, iter_steps)
    x_range = range(-frame, frame, 2)
    plot!(plt,(x_range, eigvecs(A)[1]/eigvecs(A)[3]*x_range), line = :dot)
    plot!(plt, (x_range, eigvecs(A)[2]/eigvecs(A)[4]*x_range), line = :dot)
    return plt
end

lindiffeq_many([-2 .5; 2 -2], x_0, y_0)


urang_y = x*b_u
vrange_y = x*b_v





diffeq(A, [.1;.1], 2, 1)[1:2]

plot(diffeq(A, [8;8], 100, .15)[1:2])
plot!(diffeq(A, [-8;8], 50, .15)[1:2])
plot!(diffeq(A, [8;-8], 50, .15)[1:2])
plot!(diffeq(A, [-8;-8], 50, .15)[1:2])
plot!(diffeq(A, [-8;-8], 50, .15)[[1,4]])


eigvecs(A)
eigvals(A)

b_u = eigvecs(A)[3]/eigvecs(A)[1]
b_v = eigvecs(A)[4]/eigvecs(A)[2]


x = [1, 2, NaN, 2, 3, 4]

plt = plot([0,0.1], Any[rand(2),sin])
for x in 0.2:0.1:π
    push!(plt, 1, x, rand())
    push!(plt, 2, x, sin(x))
end
plt