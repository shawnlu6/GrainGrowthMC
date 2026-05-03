function calc_energy(grain, site)
    """
    Calculate the energy of a site.
    Args:
        grain: 1-dimensional grid of orientation states.
        site: Site index.
    Returns:
        Energy of the site.
    """

    x, y, z = Tuple(CARTESIAN_IDX[site])
    energy = 0

    @inbounds for (dx, dy, dz) in NEIGHBOR_TYPE
        nx = mod1(x + dx, GRID_X)
        ny = mod1(y + dy, GRID_Y)
        nz = mod1(z + dz, GRID_Z)
        energy += grain[site] != grain[LINEAR_IDX[nx, ny, nz]] ? 1 : 0
    end

    return energy
end