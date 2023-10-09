using Statistics
using Plots
using RDatasets
using GLM

#---

trees = dataset("datasets", "trees")

scatter(trees.Girth, trees.Volume,
        legend=false, xlabel="Girth", ylabel="Volume")

#---

scatter(trees.Girth, trees.Volume,
        legend=false, xlabel="Girth", ylabel="Volume")
plot!(x -> -37 + 5*x)

#---

linmod1 = lm(@formula(Volume ~ Girth), trees)

#---

linmod2 = lm(@formula(Volume ~ Girth + Height), trees)

#---

r2(linmod1)
r2(linmod2)

linmod3 = lm(@formula(Volume ~ Girth + Height + Girth*Height), trees)

r2(linmod3)

#---

using CSV
using HTTP

http_response = HTTP.get("https://vincentarelbundock.github.io/Rdatasets/csv/AER/SwissLabor.csv")
SwissLabor = DataFrame(CSV.File(http_response.body))

SwissLabor[!,"participation"] .= (SwissLabor.participation .== "yes")

#---

model = glm(@formula(participation ~ age), SwissLabor, Binomial(), ProbitLink())