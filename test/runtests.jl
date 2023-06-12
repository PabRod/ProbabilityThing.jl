using ProbabilityThing
using Test

@testset "Generic distribution properties" begin
    for distribution in [
        Normal(),
        Uniform(),
    ]

    @testset "For distribution $distribution" begin
        @test pdf(distribution, 0.0) > 0
        @test cdf(distribution, Inf) ≈ 1 #atol = ...
        @test isapprox(cdf(distribution, Inf), 1.0) # Equivalent to previous
        end
    end
end