push!(LOAD_PATH, "src")
using Documenter
# ENV["GKSwstype"] = "100"

# generated_path = joinpath(@__DIR__, "src")
# base_url = "https://github.com/JuliaTurkuDataScience/MicrobiomeAnalysis.jl/blob/main/"
# isdir(generated_path) || mkdir(generated_path)
#
# open(joinpath(generated_path, "readme.md"), "w") do io
#     # Point to source readme file
#     println(
#         io,
#         """
#         ```@meta
#         EditURL = "$(base_url)README.md"
#         ```
#         """,
#     )
#     # Write the contents out below the meta block
#     for line in eachline(joinpath(dirname(@__DIR__), "README.md"))
#         println(io, line)
#     end
# end

makedocs(format = Documenter.HTML(),
         authors = "Giulio Benedetti",
         sitename = "PkgTutorial.jl",
         pages=[
            "Home" => "index.md",
            "First steps" => Any[
                "Basics" => "01_basics.md",
                "Package Template" => "02_pkg_template.md",
                "Dependency Management" => "03_manage_deps.md",
                "Feature Development" => "04_new_features.md"
            ],
            "Tests" => Any[
                "Unit Testing" => "05_unit_test.md",
                "Code Coverage" => "06_code_cov.md"
            ],
            "Documentation" => Any[
               "Docs Generation" => "07_write_docs.md",
               "Docs Deployment" => "08_host_docs.md"
            ],
            "Registration" => "09_pkg_reg.md",
            "Next steps" => "10_sources.md"
        ]
)

deploydocs(repo="github.com/JuliaTurkuDataScience/PkgTutorial.jl", push_preview=true)
