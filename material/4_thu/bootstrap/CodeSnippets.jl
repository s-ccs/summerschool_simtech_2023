using Distributions
using Statistics
using StatsPlots

d = Normal(0.0, 1.0)
n = 100
x = rand(d, n)
θ = mean(x)

#---

σ = std(x)
est_d = Normal(θ, σ/sqrt(n))
plot(est_d, legend=false)

ci_bounds = quantile(est_d, [0.025,0.975])
vline!(ci_bounds)

#---

B = 1000
est_vector = zeros(B)
for i in 1:B
  x_new = rand(d, n)
  est_vector[i] = mean(x_new)
end    
histogram(est_vector, legend=false)

ci_bounds_new = quantile(est_vector, [0.025, 0.975])
vline!(ci_bounds_new)

#---

est_vector_bs = zeros(B)
for i in 1:B
  x_bs = rand(x, n)
  est_vector_bs[i] = mean(x_bs)
end
histogram(est_vector_bs, legend=false)

ci_bounds_bs = quantile(est_vector_bs, [0.025, 0.975])
vline!(ci_bounds_bs) 

#---

# the following function generates a sample of (strongly) 
# correlated normal data with mean μ and variance 1
myrandn = function (mu=0.0, n=1)
  rho = 0.9
  res = zeros(n)
  res[1] = randn(1)[1]
  if n > 1
    for i in 2:n
      res[i] = rho*res[i-1] .+ sqrt(1-rho^2)*randn(1)[1]
    end
  end
  res .= mu .+ res
  return(res)
end 

## Assume we obtained the following data
n = 20
true_mu = 1.0
y = myrandn(true_mu, n)
est_mu = mean(y)

## theoretical standard error
B = 1000
est_vector = zeros(B)
for i in 1:B
  y_new = myrandn(true_mu, n)
  est_vector[i] = mean(y_new)
end    
std(est_vector)

## classical i.i.d. bootstrap
est_vector_bs = zeros(B)
for i in 1:B
  y_bs = rand(y, n)
  est_vector_bs[i] = mean(y_bs)
end
std(est_vector_bs)

## parametric bootstrap
est_vector_pbs = zeros(B)
for i in 1:B
  y_pbs = myrandn(est_mu, n)
  est_vector_pbs[i] = mean(y_pbs)
end    
std(est_vector_pbs)

# ---
myrand = function(mu, n) 
  rho = 0.9
  res = zeros(n)
  res[1] = rand(1)[1]
  if n > 1
    for i in 2:n
      res[i] = rho*res[i-1] .+ (1-rho)*rand(1)[1]
    end
  end
  res .= mu - 0.5 .+ res
  return(res)
end 
