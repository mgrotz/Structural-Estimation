# A Small Julia Cheat Sheet

## Part 1: Basics

<https://jump.dev/JuMP.jl/stable/tutorials/getting_started/getting_started_with_julia/#Getting-started-with-Julia>

```
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
```

ranges are constructed as start:stop, or start:step:stop.

## Comprehensions
```julia
[i for i in 1:5]
[i * j for i in 1:5, j in 5:10]
Dict("$(i)" => i for i in 1:10 if i % 2 == 1)
```

## Functions
```julia
function mult(x; y = 2.0)
           return x * y
       end
```
### Anonymous Functions
```julia
f = x -> x^2
map(x -> x^2, 1:4)
```


### Type parameters

```
function foo(x::Int)
           return x^2
       end
```

## Mutable vs immutable objects
```julia
# isimmutable()
```
## Packages

using Random  # The equivalent of Python's `from Random import *`

julia> import Random  # The equivalent of Python's `import Random`

### Package environmentents

import Pkg; Pkg.activate("/path/to/environment")

# JuMP

<https://jump.dev/JuMP.jl/stable/tutorials/getting_started/getting_started_with_JuMP/#Getting-started-with-JuMP>

## Working with and emulating References