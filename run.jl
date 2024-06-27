using Trixi
using OrdinaryDiffEq
using MPI

function main(elixir_path)

    comm = MPI.COMM_WORLD
    rank = MPI.Comm_rank(comm)
    isroot = rank == 0

    if isroot
        println("Precompiling...")
    end

    # start simulation with tiny final time to trigger precompilation
    duration_precompile = @elapsed trixi_include(elixir_path,
        tspan=(0.0, 1e-14))

    if isroot
        println("Finished precompilation in $duration_precompile seconds\n")
        println("Starting simulation...")
    end

    # start the real simulation
    initial_refinement_level = 2
    trees_per_dimension = (4, 4, 4)
    maxiters = 400
    duration_elixir = @elapsed trixi_include(elixir_path,
        initial_refinement_level=initial_refinement_level,
        trees_per_dimension=trees_per_dimension,
        maxiters=maxiters)
end


elixir_path = joinpath(@__DIR__(), "elixirs/elixir_euler_taylor_green_vortex.jl")

main(elixir_path)

