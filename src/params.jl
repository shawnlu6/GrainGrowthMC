# grid size parameters
const GRID_X::Int = 300
const GRID_Y::Int = 300
const GRID_Z::Int = 300

# system parameters
const K_T::Float64 = 0.7 # system temperature
const Q::Int = 128 # Number of orientation states

# mode control parameters
const MCS_STEPS::Int = 1000
const SAVE_STEPS::Int = 200

# neighborhood parameters
const NEIGHBOR_TYPE = [(dx, dy, dz) for dx in [-1, 0, 1], dy in [-1, 0, 1], dz in [-1, 0, 1] if (dx, dy, dz) != (0, 0, 0)] # 3D-Moore neighborhood
const N_NEIGHBOR::Int = length(NEIGHBOR_TYPE) # Number of neighbors for each site in 3D-Moore neighborhood

# index parameters for linear indexing (no change needed)
const LINEAR_IDX = LinearIndices((1:GRID_X, 1:GRID_Y, 1:GRID_Z))
const CARTESIAN_IDX = CartesianIndices((GRID_X, GRID_Y, GRID_Z))