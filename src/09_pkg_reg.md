# Register the new package

Before registering your package, consider the following checklist:

* package successfully compiles on a local machine
* functions and utilities are loaded and callable
* docs are rendered and include utility docstrings
* code coverage lies above 70% and tests don't fail

If so, then the next step is to install `Registrator.jl` on your GitHub repository through
[these instructions](https://juliapackages.com/p/registrator) and add a new workflow as `.github/workflows/TagBot.yml`:

```
name: TagBot
on:
  issue_comment:
    types:
      - created
  workflow_dispatch:
jobs:
  TagBot:
    if: github.event_name == 'workflow_dispatch' || github.actor == 'JuliaTagBot'
    runs-on: ubuntu-latest
    steps:
      - uses: JuliaRegistries/TagBot@v1
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          ssh: ${{ secrets.DOCUMENTER_KEY }}
```

The workflow above opens a pull request in the General Registry every time you write the comment `@JuliaRegistrator register` inside an issue of your repo. After registration is triggered, you can check if the pull request passes all the checks and can therefory be automatically merged after a stopwatch time of about 3 days. Usually, a few fixes might be necessary, such as:

* setting compat requirements for dependencies and julia itself (I recommend "1" for the latter)
* changing the package name because it's too short or too similar to other package names

For the first case, just update the `Compat.toml`, commit and retrigger the registrator with the comment; the pull request will be updated. For the second case, you'll have to change the name of your repo and triggering registration will open a new pull request. The change of name might also cause some issues for the docs deployment, so make sure that you changed all occurrences of the name in the `Documenter.yml` as well.

New versions can also be registered with this method, but the version has to be manually upgraded in the `Project.toml` and should follow the guidelines for semantic versioning. In addition, packages can also be submitted via the JuliaHub interface, which is more user-friendly for those who are not familiar with GitHub issues.

Learn more about package registration, the General Registry and semantic versioning at [JuliaHub](https://juliahub.com/ui/Packages), [standard and guidelines](https://github.com/JuliaRegistries/General) and [this specification](https://semver.org/).
