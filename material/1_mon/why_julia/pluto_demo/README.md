# Brief demonstration of Julia and Pluto.jl notebooks

This brief demo gives a first impression how Julia looks like.
It also contains an example I used in teaching a class on
numerical methods for partial differential equations.

Run

```bash
julia --project=. -e 'import Pkg; Pkg.instantiate(); import Pluto; Pluto.run()'
```

in this directory. Then, open the Pluto notebook `pluto_demo.jl`.

This code was developed with Julia v1.9.3.
