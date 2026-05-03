function label_grains(grain)
    """
    Label grains with unique number using BFS.
    Args:
        grain: 1-dimensional grid of orientation states.
    Returns:
        labels: 1-dimensional grid of grain labels.
    """

    n_site = length(grain)
    labels = zeros(Int, n_site)
    current_label = 0

    queue = Vector{Int}(undef, n_site)
    head = 1
    tail = 1

    @inbounds for idx in 1:n_site

        labels[idx] != 0 && continue

        current_label += 1
        current_orientation = grain[idx]
        labels[idx] = current_label

        queue[tail] = idx
        tail += 1

        while head < tail
            site = queue[head]
            head += 1

            x, y, z = Tuple(CARTESIAN_IDX[site])

            for (dx, dy, dz) in NEIGHBOR_TYPE
                nx = mod1(x + dx, GRID_X)
                ny = mod1(y + dy, GRID_Y)
                nz = mod1(z + dz, GRID_Z)

                neighbor = LINEAR_IDX[nx, ny, nz]

                if labels[neighbor] == 0 && grain[neighbor] == current_orientation
                    labels[neighbor] = current_label
                    queue[tail] = neighbor
                    tail += 1
                end
            end
        end
    end
    return labels
end
