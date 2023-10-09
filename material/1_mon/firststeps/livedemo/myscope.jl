a = zeros(10)
for k = 1:10
    a[k] = k
end
a
#---
# composite type
# abstract type

struct SimulationResults
    parameters
    results::Union{Nothing,Int}
end
function SimulationResults(params)
        results = rand(100)*params[1]
        return SimulationResults(params,results)
end




function print(s::NamedTuple)
println("hey, please use SimulationResults next time ;)")
end

import Base: show
function Base.show(io::IO,s::SimulationResults)
    println(io,"The following simulation was run:")
    println(io,"Parameters: ",s.parameters)
    println(io,"And we got results!")
    println(io,"Results: ",s.results[1])
end
#---


