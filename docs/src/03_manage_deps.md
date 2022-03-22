# Manage dependencies

You might wonder how your package keeps track of its credentials, such as name, uuid, authors and name, as well as more practical stuff like dependencies, campatibility requirements and similar things. All this information is stored in the `Project.toml`.

Especially when it comes to dependencies, it is not a smart idea to manually modify the keys and values within this file; it is much more efficient to leave this job to the Julia package manager, which you can access by typing the special key `]`. For instance, you can activate the current project and  automatically add new deps to it as follows:

```julia
# switch to the package manager command line
]
# activate the project defined by the "Project.toml" in the current directory
activate .
# check project status and current dependencies
status
# add new dependencies to the "Project.toml"
add FdeSolver, MicrobiomeAnalysis
```

If you then check the `Project.toml`, you'll see the new deps listed under `[deps]`.

Another important matter is addressed by the `[compat]` section of this file; namely, it accounts for the compatibility requirements of your package utilities. Again, those keys don't have to be inserted manually, since Julia provides the so-called CompatHelper bot which takes care of the compat requirements for you by making pull requests in the GitHub repo. To trigger the bot, all you need to do is include the following GitHub Actions workflow as `.github/workflows/CompatHelper.yml`:

```
name: CompatHelper
on:
  schedule:
    - cron: 0 0 * * *
  workflow_dispatch:
jobs:
  CompatHelper:
    runs-on: ubuntu-latest
    steps:
      - name: Pkg.add("CompatHelper")
        run: julia -e 'using Pkg; Pkg.add("CompatHelper")'
      - name: CompatHelper.main()
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          COMPATHELPER_PRIV: ${{ secrets.DOCUMENTER_KEY }}
        run: julia -e 'using CompatHelper; CompatHelper.main()'
```

A word of care should be made that the CompatHelper doesn't check whether the deps you added make sense, it just finds the best compat requirement, so you are responsible to provide only those dependencies that are meaningful for your package.

Learn more about package components and dependencies, the Julia REPL and the CompatHelper at [Pkg.jl](https://pkgdocs.julialang.org/v1/), [Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/) and [CompatHelper.jl](https://juliaregistries.github.io/CompatHelper.jl/stable/).
