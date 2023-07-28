# A Small Julia Cheat Sheet

## Part 1: Basics

https://jump.dev/JuMP.jl/stable/tutorials/getting_started/getting_started_with_julia/#Getting-started-with-Julia


Running text files: include("path/to/file.jl")
typeof()
println()
$() for extrapolation
""" for multiline string """
Symbols are Strings that take up less memory and cannot be modified
Symbol("abc") gives symbol value of string
Tuple: ("hello", 1.2, :foo) can be accessed t[]
t = (word = "hello", num = 1.2, sym = :foo). Accessed t.word
d1 = Dict(1 => "A", 2 => "B", 4 => "D")
Structs can be defined: 
struct MyStruct
           x::Int
           y::String
           z::Dict{Int,Int}
       end
or mutable struct

for i in 1:5
   println(i)
end

ranges are constructed as start:stop, or start:step:stop.

## Comprehensions

[i for i in 1:5]
[i * j for i in 1:5, j in 5:10]
Dict("$(i)" => i for i in 1:10 if i % 2 == 1)

## Functions

function mult(x; y = 2.0)
           return x * y
       end

## Anonymous Functions
f = x -> x^2
map(x -> x^2, 1:4)
=#