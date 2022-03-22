# Basics

To start off, write down some content in a julia script, say `example.jl`; for instance, it may entail a working example of the functionality you'd like to offer through your new package. Once you realise that some of the code you wrote could be wrapped up into one or more functions, define those functions and move them into a separate file, say `main.jl`.

You can now import the utilities from `main.jl` to `example.jl` with:

```julia
include("main.jl")
```

But if `main.jl` lives in a subdirectory, you'll have to let Julia know about it. One option is to specify the relative path of the file in the `include` command. A better option is to push a custom path in the loading path of Julia:

```julia
push!(LOAD_PATH, "subdirectory")
```

Also, if you want to use external utilities, call them in `main.jl` and they will also be exported in `example.jl`:

```julia
# lazy load module
import FdeSolver
# load module and export all functions
using MicrobiomeTools
```

All of the above works as a good temporary solution, as long as you don't need external utilites or multiple source scripts. In such case, you might want to define a module within a new file `SomeModule.jl`, wich will function as the core of your new package:

```julia
# define module to load all ingredients you need for your package to work
module SomeModule

# 1. load externals
import FdeSolver
using MicrobiomeTools

# 2. include internals
include("main1.jl")
include("main2.jl")

# 3. export internals
export my_function1
export my_function2

end
```

Now you can run something like `using SomeModule` in your `example.jl` script and hopefully you'll have access to your functions without having to deal with errors. If you do run into errors, try to troubleshoot with `push!` or reboot Julia.

Learn more about modules at [JuliaLang](https://docs.julialang.org/en/v1/manual/modules/) and [JuliaNotes.jl](https://m3g.github.io/JuliaNotes.jl/stable/modules/).
