#=
Hallo
=#

1 + 1
sin(5)

using Statistics

mean([1, 2, 3, 4])

import Statistics

Statistics.mean()

# activate .
# creates new project in location
# Can be found in Manifest.toml and Project.toml
# Manifast has all 

using DataFrames
df = DataFrame(col1 = [1, 2, 3], col2 = ["red", "blue", "green"])
df.col1
df[:, :col1] # symbol. Referencing a certain domain that is fixed in size
df[:, "col1"] # both works, but symbols are fixed in size
df[!, "col3"] = rand(3) #with ! we can edit
df

typeof(1)
typeof(2//3)

# 'a' are single characters

# Unicode characters

π #\pi 
δ #\delta

stringv = String["a", "b"]

import Pkg

Pkg.add("OhMyREPL")