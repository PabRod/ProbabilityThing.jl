module ProbabilityThing

using QuadGK

# Include order from more to less abstract
include("abstract.jl")
include("api.jl")

include("normal.jl")
include("uniform.jl")

end
