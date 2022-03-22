# Make a package template

It might be time-consuming to build your own architecture from scratch, but thanks to [PkgTemplates.jl](https://invenia.github.io/PkgTemplates.jl/stable/) this procedure is automatic:

```
# create a package template named "MyPkg"
using PkgTemplates
t = Template()
t("MyPkg")
```

There is a bunch of additional plugins and features that you can insert in your package draft, such as CI and documentation, but I suggest that you don't overdo with them, because they make it more difficult to find your way among the many generated files. More often than not I just create a basic template with the command above and then add more features manually.

Also, it is good practice to generate the draft package in an empty directory and only then you import the modules and examples that you've already written. You can put the former in the `src` and the latter in the `examples` directories, respectively.

Learn more about package templates at [PkgTemplates.jl](https://invenia.github.io/PkgTemplates.jl/stable/user/) and [JuliaLang](https://discourse.julialang.org/t/upload-new-package-to-github/56783).
