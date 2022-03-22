# Analyse code coverage

It's time to automatise unit testing and code coverage analysis. There are several options out there, but personally I fancy Codecov, because it's free open source and doesn't give too many problems. Begin with adding the following workflow to your `.github/workflows/` directory, maybe as `CI.yml`:

```
name: CI
on:
  - push
  - pull_request
jobs:
  test:
    name: Julia ${{ matrix.version }} - ${{ matrix.os }} - ${{ matrix.arch }} - ${{ github.event_name }}
    runs-on: ${{ matrix.os }}
    strategy:
      fail-fast: false
      matrix:
        version:
          - '1.6'
          - 'nightly'
        os:
          - ubuntu-latest
          - macOS-latest
        arch:
          - x64
    steps:
      - name: Check out
        uses: actions/checkout@v2

      - name: Set up Julia
        uses: julia-actions/setup-julia@v1
        with:
          version: ${{ matrix.version }}
          arch: ${{ matrix.arch }}

      - name: Load cache
        uses: actions/cache@v1
        env:
          cache-name: cache-artifacts
        with:
          path: ~/.julia/artifacts
          key: ${{ runner.os }}-test-${{ env.cache-name }}-${{ hashFiles('**/Project.toml') }}
          restore-keys: |
            ${{ runner.os }}-test-${{ env.cache-name }}-
            ${{ runner.os }}-test-
            ${{ runner.os }}-
      - name: Build package
        uses: julia-actions/julia-buildpkg@v1

      - name: Run tests
        uses: julia-actions/julia-runtest@v1

      - name: Process code coverage
        uses: julia-actions/julia-processcoverage@v1

      - name: Run codecov action
        uses: codecov/codecov-action@v1
        with:
          file: lcov.info
        env:
          CODECOV_TOKEN: ${{ secrets.CODECOV_TOKEN }}
```

The last line up here will look for a secret token stored in your repository to connect and upload the code coverage reports to Codecov, so go to your [Codecov](https://about.codecov.io/) account, enable access to your repository and store the secret token provided by Codecov in the settings of your repo. After a couple of commits, you should start to see percent coverage and other statistics on the Codecov page of your repo and can also add the Codecov badge to its README.

Learn more about code coverage at [this tutorial](https://github.com/codecov/example-julia) and [Codecov Quick Start](https://docs.codecov.com/docs/quick-start).
