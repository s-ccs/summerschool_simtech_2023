# # Optimizing Julia code: possible solution

# First, we install all required packages
import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()

# The markdown file is created from the source code using
# [Literate.jl](https://github.com/fredrikekre/Literate.jl).
# You can create the markdown file via

using Literate
Literate.markdown(joinpath(@__DIR__, "optimizing_julia_solution.jl");
                  flavor = Literate.CommonMarkFlavor())

# First, we generate initial data and store it in a file.
using HDF5
x = range(-1.0, 1.0, length = 1000)
dx = step(x)
h5open("initial_data.h5", "w") do io
    u0 = sinpi.(x)
    write_dataset(io, "x", collect(x))
    write_dataset(io, "u0", u0)
end

function simulate(; kwargs...)
    x, u0 = h5open("initial_data.h5", "r") do io
        read_dataset(io, "x"), read_dataset(io, "u0")
    end

    u = copy(u0)
    t = simulate!(u; kwargs...)

    return t, x, u, u0
end

function simulate!(u; t_end, dt, dx)
    du = similar(u)
    t = zero(t_end)
    while t < t_end
        rhs!(du, u, dx)
        # u = u + dt * du
        # u .= u .+ dt .* du
        @. u = u + dt * du
        t = t + dt
    end

    return t
end

function rhs!(du, u, dx)
    inv_dx = inv(dx)

    let i = firstindex(u)
        im1 = lastindex(u)
        # du[i] = -(u[i] - u[im1]) / dx
        du[i] = -inv_dx * (u[i] - u[im1])
    end

    for i in (firstindex(u) + 1):lastindex(u)
        im1 = i - 1
        # du[i] = -(u[i] - u[im1]) / dx
        du[i] = -inv_dx * (u[i] - u[im1])
    end
    return nothing
end

# Now, we can define our parameters, run a simulation,
# and plot the results.
using Plots, LaTeXStrings

t_end = 2.5
dt = 0.9 * dx
t, x, u, u0 = simulate(; t_end, dt, dx)
plot(x, u0; label = L"u_0", xguide = L"x")
plot!(x, u; label = L"u")


using BenchmarkTools
@benchmark simulate(; t_end, dt, dx)

let u = h5open("initial_data.h5", "r") do io
        read_dataset(io, "u0")
    end
    @benchmark simulate!(u; t_end, dt, dx)
end
