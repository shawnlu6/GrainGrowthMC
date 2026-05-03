#!/usr/bin/env julia

using Pkg
Pkg.activate("..")
Pkg.instantiate()

include("params.jl")
include("energy.jl")
include("neighbor.jl")
include("simulation.jl")
include("bfs_label.jl")
include("fileIO.jl")

# Main function
main()