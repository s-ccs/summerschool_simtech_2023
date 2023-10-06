
function find_max(x::AbstractVector)
    @assert all(!isnan,x)
    currentmax = x[1]
    for a = eachindex(x)
        if x[a] > currentmax
            currentmax = x[a]
        end
    end
    return currentmax
end

function find_mean(x::AbstractVector)
    @assert all(!isnan,x)
    return sum(x)./length(x)
end
