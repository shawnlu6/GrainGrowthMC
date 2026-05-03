function get_neighbor_orientation(grain, site, neighbor_idx)
    """
    Get the neighbors orientation of a site by neighbor_idx.'
    Args:
        grain: 1-dimensional grid of orientation states.
        site: Site index.
        neighbor_idx: random selected neighbor index in 3D-Moore.
    Returns:
        Orientation of the neighbor.
    """

    x, y, z = Tuple(CARTESIAN_IDX[site])
    (dx, dy, dz) = NEIGHBOR_TYPE[neighbor_idx]
    nx = mod1(x + dx, GRID_X)
    ny = mod1(y + dy, GRID_Y)
    nz = mod1(z + dz, GRID_Z)

    return grain[LINEAR_IDX[nx, ny, nz]]
end