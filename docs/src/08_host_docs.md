# Host documentation online

Deploying the docs online should go quite smoothly if you managed to build them locally. In case you didn't, deployment on a GitHub Actions host server could actually solve the issues and conflicts you had locally, because it helps run the code in an isolated environment where conflicts between package versions and dependencies are less likely to happen, and if they do happen, that ensures you that is a global problem that inevitably needs to be solved and is not due to your own machine.

First off, add this workflow to your `.github/workflows` directory, maybe as `Documenter.yml`:

```
name: Documenter
on:
  - push
  - pull_request
jobs:
  docs:
    name: Documentation
    runs-on: ubuntu-latest
    steps:
      - name: Check out
        uses: actions/checkout@v2

      - name: Set up Julia
        uses: julia-actions/setup-julia@v1
        with:
          version: '1.7'

      - name: Build package
        run: |
          julia --project=docs -e '
            import Pkg; Pkg.add("Documenter")
            using Pkg
            Pkg.develop(PackageSpec(path=pwd()))
            Pkg.instantiate()'
      - name: Run doctests
        run: |
          julia --project=docs -e '
            import Pkg; Pkg.add("Documenter")
            using Documenter: doctest
            using ProjectName
            doctest(ProjectName)'
      - name: Deploy documentation
        run: julia --project=docs docs/make.jl
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          DOCUMENTER_KEY: ${{ secrets.DOCUMENTER_KEY }}
```

Next, commit the changes to main. After the workflow has run, a new branch "gh-pages" should be automatically created. In case it isn't, you have to go to the repo settings and manually set gh-pages as the default branch for deployment. From now on, every time you push a new tag to main, the latest version of the docs will be rendered at "https://OrganisationName.github.io/ProjectName.jl/stable/". Practically, here's what you need to do to trigger deployment:

```bash
# commit changes locally
git commit -m "Add new features"
# create a new tag locally
git tag -a v0.1.0 -m "Release version 0.1.0"
# push changes to origin/main
git push origin main
# push tags to origin
git push --tag
```

Then the `Documenter.jl` workflow should be triggered and will be followed by another workflow named "pages build and deployment", which will present you the link to your new website. It is nice to wrap it up into a badge and showcase it in the README.

Keep in mind that reusing tags, pushing commits but no new tags or tags but no new commits won't trigger deployment (yes, I tried all of that). Sometimes you might need to delete older tags both locally and on GitHub, because they tend to cluster very quickly and you can't come up with any new names for the tags. Sometimes you also need to clear the cookies from your browser before you're able to see the latest version of the docs.

Learn more about hosting documentation at [JuliaNotes.jl](https://m3g.github.io/JuliaNotes.jl/stable/publish_docs/) and [Documenter.jl](https://juliadocs.github.io/Documenter.jl/stable/man/hosting/).
