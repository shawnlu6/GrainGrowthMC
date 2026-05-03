function save_state(grain3D, step, output_dir)
    """
    Save the state of the system.
    Args:
        grain3D: 3-dimensional grid of orientation states.
        step: Step number.
        output_dir: Output directory.
    """

    vtk_filename = "grain_step_$(step)"
    filename = joinpath(output_dir, vtk_filename)
    vtk = vtk_grid(filename, 0:GRID_X, 0:GRID_Y, 0:GRID_Z)
    vtk["orientation"] = grain3D
    vtk_save(vtk)

    h5_filename = "grain_step_$(step).h5"
    filename = joinpath(output_dir, h5_filename)
    h5open(filename, "w") do file
        write(file, "orientation", grain3D)
        file["grid"] = [GRID_X, GRID_Y, GRID_Z]
    end
end