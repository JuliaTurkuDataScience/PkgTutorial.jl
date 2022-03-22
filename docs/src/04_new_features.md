## Develop new features

From now on, I suggest that you follow these steps every time you enter Julia and want to further build your package, here named "ProjectName":

```julia
# switch to shell command line
;
# set project as working directory
cd ProjectName.jl/
[delete-key]
# switch to package manager command line
]
# activate current project
activate .
[delete-key]
# load project utilities
using ProjectName
```

Initially, many different errors might arise due to precompilation issues and local conflicts between different versions of the package being developed. There is no single and easy solution for this and sometimes you just have to live with it until the package gets registered, but note that those are mainly local issues and everything (the package building) should run smoothly on the GitHub Actions host machine, once you set it up.

Still, you can try to start Julia with a few optargs to skip precompilation and directly activate your project:

```bash
cd ProjectName.jl
julia --startup-file=no --project=.
```

Learn more about setting up project environments in [this article](https://towardsdatascience.com/how-to-setup-project-environments-in-julia-ec8ae73afe9c).
