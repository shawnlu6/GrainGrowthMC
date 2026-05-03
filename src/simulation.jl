using Random
using Dates
using WriteVTK
using Printf
using ProgressMeter
using HDF5

function main()
    """
    Three-dimensional grain growth by Monte Carlo method.   
    """

    # uncomment the line below to set the seed
    #Random.seed!(42)

    start_time = time()

    println("="^60)
    println("THREE-DIMENSIONAL GRAIN GROWTH BY MONTE CARLO METHOD")
    println("     Start time: ", now())
    println("="^60)

    println("Simulation parameters:")
    println("-"^30)
    println("Grid size: $(GRID_X) x $(GRID_Y) x $(GRID_Z)")
    println("Number of orientation states: $(Q)")
    println("System temperature: $(K_T)")
    println("Number of Monte Carlo steps: $(MCS_STEPS)")
    println("Save steps: $(SAVE_STEPS)")
    println("="^60)

    println("Simulation start >>> ")

    n_site = GRID_X * GRID_Y * GRID_Z # Number of sites in the grid
    grain = rand(1:Q, n_site) # 1-dimensional grid of orientation states

    current_file_path = abspath(PROGRAM_FILE)
    root_path = dirname(dirname(current_file_path))
    output_dir = joinpath(root_path, "output")
    isdir(output_dir) && rm(output_dir; recursive=true, force=true)
    mkpath(output_dir)
    println("Output directory created: $(output_dir)")

    # save the initial state of the system
    save_state(reshape(grain, GRID_X, GRID_Y, GRID_Z), 0, output_dir)

    selected_neighbor = Vector{Int}(undef, n_site)
    selected_sites = Vector{Int}(undef, n_site)
    growth_prob = K_T > 0.0 ? Vector{Float64}(undef, n_site) : similar(selected_sites, 0.0)

    @inbounds @showprogress 1 "MCS_running..." for step in 1:MCS_STEPS

        rand!(selected_sites, 1:n_site)
        rand!(selected_neighbor, 1:N_NEIGHBOR)
        K_T > 0.0 && rand!(growth_prob)

        for idx in 1:n_site
            site = selected_sites[idx]
            current_orientation = grain[site]
            current_energy = calc_energy(grain, site)
            new_orientation = get_neighbor_orientation(grain, site, selected_neighbor[idx])

            new_orientation == current_orientation && continue

            grain[site] = new_orientation
            new_energy = calc_energy(grain, site)
            delta_energy = new_energy - current_energy

            if delta_energy > 0 && (K_T == 0.0 || growth_prob[idx] >= exp(-delta_energy / K_T))
                grain[site] = current_orientation
            end
        end

        (step % SAVE_STEPS == 0 || step == MCS_STEPS) && save_state(reshape(grain, GRID_X, GRID_Y, GRID_Z), step, output_dir)

    end

    # label the grains with unique number using BFS
    labels = label_grains(grain)

    println("Simulation done <<<")
    println("Total number of grains after growth: $(maximum(labels))")
    total_time = time() - start_time
    println("Time elapsed: ", round(total_time / 60.0, digits=2), " minutes")
    println("="^60)
end
