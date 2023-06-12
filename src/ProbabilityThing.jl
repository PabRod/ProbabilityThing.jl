module ProbabilityThing

export Normal, Uniform
export mean
export pdf, cdf

# ╔═╡ d688f3db-ee38-4b78-b488-77f292925333
using QuadGK

# ╔═╡ 2f65aadc-cb40-489f-ac01-2738ebd2c9c1
abstract type AbstractDistribution end

struct Normal <: AbstractDistribution
    μ::Float64 # \mu
    σ::Float64 # \sigma

    function Normal(μ, σ)
        if σ <= 0
            error("σ must be positive")
        end
        return new(μ, σ)
    end
end

function Normal()
    return Normal(0.0, 1.0)
end

struct Uniform <: AbstractDistribution
    a::Float64
    b::Float64

    function Uniform(a=0.0, b=1.0)
        if b <= a
            error("a must be smaller than b")
        end
        return new(a, b)
    end
end

function mean(X::Normal)
    return X.μ
end

function mean(U::Uniform)
    return (U.a + U.b) / 2
end

"""
    y = pdf(D :: AbstractDistribution, x)
Computes the probability density function of D at value x.
## Inputs
- `D :: AbstractDistribution`: The probability variable
"""
function pdf end

function pdf(D::Normal, x)
    return exp(-(D.μ - x)^2 / 2 / D.σ^2) / D.σ / √(2π) #\sqrt
end

function pdf(D::Uniform, x)
    if D.a ≤ x ≤ D.b
        return 1 / (D.b - D.a)
    end
    return zero(x)
end

function cdf(D::AbstractDistribution, x)
    integral, err = quadgk(
        y -> pdf(D, y),
        -Inf,
        x,
    )
    return integral
end

function cdf(D::Uniform, x)
    if x ≤ D.a
        0.0
    elseif x ≥ D.b
        1.0
    else
        (x - D.a) / (D.b - D.a)
    end
end


end
