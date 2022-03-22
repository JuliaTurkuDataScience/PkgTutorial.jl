# Write and deploy documentation

Now we'll look into the `docs` directory, which is responsible for the building and deployment of the documentation. This directory has its own `Project.toml`, therefore you can activate it and add new deps just like you did for the main project. At least, it should contain `Documenter` (the documentation generator for Julia) and your main project as `[deps]` entries.

The package template has already prepared the files `src/index.md`, which serves as the home page of the deployed docs, and `make.jl`, which tells Julia how to build the docs, what dependencies to load, what files to include and in which order they should appear. The latter should look something like this:

```julia
using ProjectName, Documenter
ENV["GKSwstype"] = "100"

base_url = "https://github.com/OrganisationName/ProjectName.jl/blob/main/"

makedocs(format=Documenter.HTML(),
         authors = "authors",
         sitename = "ProjectName.jl",
         modules = [ProjectName],
         pages=[
             "Home" => "index.md",
             "Examples" => "examples.md"
               ])

deploydocs(repo="github.com/OrganisationName/ProjectName.jl", push_preview=true)
```

After you've added some content to the `index.md` and maybe also to `examples.md` (down below we see worthwhile material to include), try to build the docs locally with the following code:

```julia
# switch to the shell command line
;
# set "docs" as working directory
cd docs
# build docs
julia make.jl
```

After a while, you'll see a `build` directory appearing in `docs`, click on `index.html` to open the local deployment of the docs.

The docs should primarily showcase the descriptions of the utilities defined in `src` just next to the main module. Those descriptions are called docstrings and you can annotate them upstream the corresponding function in the `src/` files. For example:

```julia
"""
    sum(a::Float64, b::Float64)
Computes the sum of `a` and `b`.
# Arguments
- `a::Float64`: first arg.
- `b::Float64`: second arg.
"""
sum(a::Float64, b::Float54) = a + b
```

The docstring enclosed between the triple quotes can then be rendered in the docs with the following syntax:

````markdown
```@docs
sum
function2
function3
```
````

Code chunks with examples can also be run inside the docs and the produced images can be added in the form of md links:

````markdown
```@repl
using ProjectName
using Plots

out = sum(2, 3)
plot(out, 2, 3)

savefig("plot1.png"); nothing # hide
```
````

And then `![plot1](plot1.png)` in the next line. Note that this might take some troubleshooting before it actually works out.

Learn more about generating documentation in Julia and docstring syntax at
[Documenter.jl](https://juliadocs.github.io/Documenter.jl/stable/).
