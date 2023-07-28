
#######################################################################
##################### STRUCTURAL ESTIMATION IN JULIA ##################
#######################################################################

#=
Based on https://juliaeconomics.com/2016/02/09/an-introduction-to-structural-econometrics-in-julia/

SUMMARY

 1. Installing Julia and packages
 2.  


=#

#=======================================================================================#
#================================= INSTALLING PACKAGES =================================#
#=======================================================================================#

using Pkg
Pkg.add("DataFrames")
Pkg.add("Makie")
Pkg.add("GLM")
Pkg.add("KernelEstimator")
Pkg.add("Optim")
Pkg.add("Ipopt")
Pkg.build("Ipopt")
Pkg.add("JuMP")
Pkg.build("JuMP")


#=======================================================================================#
#============= DATA GENERATION, MANAGEMENT AND REGRESSION VISUALISATION ================#
#=======================================================================================#
using Random
Random.seed!(123)           # set the seed to ensure reproducibility
N = 1000             # set number of agents in economy
gamma = .5           # set Cobb-Douglas relative preference for consumption
tau = .2             # set tax rate
 


#=======================================================================================#
#================ DRAW INCOME DATA AND OPTIMAL CONSUMPTION AND LEISURE =================#
#=======================================================================================#

epsilon = randn(N)                                               # draw unobserved non-labor income
wage = .+(10, randn(N))                                               # draw observed wage
consump = gamma*(1-tau)*wage + gamma*epsilon                     # Cobb-Douglas demand for c
leisure = (1.0-gamma) .+ ((1.0-gamma)*epsilon)./((1.0-tau)*wage)  # Cobb-Douglas demand for l



using DataFrames
using CairoMakie
df = DataFrame(consump=consump,leisure=leisure,wage=wage,epsilon=epsilon)  # create data frame
f = Figure(backgroundcolor = :tomato, resolution = (800, 600))
ax = Axis(f[1, 1], 
title = "Sumulation data", xlabel = "The x label", ylabel = "The y label")
x = df[:, :wage]
y = df[:, :consump]
f
#or scatter(x, y)
scatter(x,y)


#=======================================================================================#
#======== NUMERICAL SIMULATION OF OPTIMAL AGENT BEHAVIOR UNDER CONSTRAINTS =============#
#=======================================================================================#

using DataFrames
using JuMP
using Ipopt

N = size(df)[1]

