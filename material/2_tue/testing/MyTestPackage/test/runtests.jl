using MyTestPackage # here it is ok to use, don't put it in your "debug"-convenience setup.jl
include("setup.jl")


@testset "find" begin
    include("find.jl")
end