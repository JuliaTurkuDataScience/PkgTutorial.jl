# Implement unit testing

Tests can be found in the `test` directory. The package template has already prepared the draft in `runtests.jl` that you can fill with `@test` macros, which check if the conditionals in the same line are true or false. For example:

```julia
using Test
using ProjectName

@testset "ProjectName.jl" begin

    var1 = 2 + 2
    var2 = 2 * 2

    @test var1 == var2

end
```

You can then run the tests locally from the package manager command line as follows:

```julia
]
activate .
# run tests defined in "test" directory
test
```

This is quite nice. However, the amount of tests you make will increase exponentially as you add more features to your package, and you might want to split the tests into multiple files to avoid confusion and conflicts among dependencies (if some utilities depend on different externals). For this, `SafeTestSets.jl` comes into play:

```julia
using SafeTestsets

@safetestset "Run first test file" begin include("test1.jl") end

@safetestset "Run second test file" begin include("test2.jl") end

@safetestset "Run third test file" begin include("test3.jl") end
```

After which, you can write tests with the same syntax as in two chunks upstream and run them as in the second-to-last chunk, with the `@safetestset` being defined in `runtests.jl` and all other `@testset` in as many files as you like. Also, don't forget to add `SageTestSets.jl` to your extras and targets in the `Project.toml`.

Learn more about unit testing and macros at [Test](https://docs.julialang.org/en/v1/stdlib/Test/) and [JuliaLang](https://discourse.julialang.org/t/best-practices-for-julia-unit-testing/30858).
