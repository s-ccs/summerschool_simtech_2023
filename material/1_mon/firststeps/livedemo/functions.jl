myarray = zeros(Float64,6)
for k = 1:length(myarray)
    if iseven(k)
        myarray[k] = sum(myarray[1:k])
    elseif k == 5
        myarray = myarray .- 1
    else 
        myarray[k] = 5

    end
end
##---
function myfunction()
    return "string",1.0
end

function myfunction(a; c="keyword",kwargs...)
    # body
    return a,b,c
end

anonym = (x,y) -> x+y

function mylongfunction(x)
    return x^2
end
myshortfunction(x) = x^2

myfunction(args...;kwargs...) = myotherfunction(1.0,"mystring",args...;kwargs...)

#---
a = [1,2,3]
a[1]+a[2]+a[3]
+(a[1],a[2],a[3])
+(a...)

function mybinary(args...)
    res = true
    for k = 1:length(args)
        res = res & args[k] 
    end
    return res
end

#---
nothing # None
NaN
missing
#---
a = [1,2,3,4,5]
sqrt.(a)
a .+ a 
#---
a = [1,2,3,4,5]
b = [6,7,8,9,10]
c = (a.^2 .+ sqrt.(a) .+ log.(a.*b))./5
#---
tmp1 = a .* b
tmp2 = log.(tmp1)
tmp3 = sqrt.(a)
tmp4 = tmp2 + tmp3 
...
output = tmpX./5

c = similar(a)
for k = 1:length(a)
    c[k] = (a[k]^2 + sqrt(a[k]) + log(a[k]*b[k]))/5
end
#---
#import LinearAlgebra
import LinearAlgebra.qr as test3
using LinearAlgebra

A = Matrix{Float64}(undef,11,22)
B = Array{Float64,2}(undef,22,33)
C = rand(30,100)
D = rand(100,50)

qr(C*D)
@time svd(C)
g = x -> 2*x
h = x -> 2*x
i = x -> 2*x
h(C);
@time svd(g(C));
@time svd(i(C));
#---
function myfunction(A::Int64)
    b::Vector = A[1,:]
    
    return A^2
end

#---
function rse_tstat(x;σ = rse_std(x),var=σ^2)
    return rse_mean(x) / (σ / sqrt(length(x)))
end
#---
β = 1
🎈 = "bla"
# \beta + TAB
a = "this is a string"
'this is a string?'
join('A':'F')
A = "one"
B = " two"
A * B
#---

module MyStatsPackage
    struct Bla
        newfield
    end
    include("myscope.jl")
    import Base: length
    Base.length(s::SimulationResult) = 100
    export SimulationResults
end

using .MyStatsPackage

#---
@kwdef 
@which sum([1,2,3])
@which(sum([1,2,3]))
a = [1,2,3]
println("a is $a")
@debug a
