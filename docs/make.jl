using Documenter, RomanNumerals

makedocs(;
    modules=[RomanNumerals],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/harryscholes/RomanNumerals.jl/blob/{commit}{path}#L{line}",
    sitename="RomanNumerals.jl",
    authors="harryscholes",
    assets=[],
)

deploydocs(;
    repo="github.com/harryscholes/RomanNumerals.jl",
)
