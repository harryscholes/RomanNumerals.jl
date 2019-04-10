# RomanNumerals.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://harryscholes.github.io/RomanNumerals.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://harryscholes.github.io/RomanNumerals.jl/dev)
[![Build Status](https://travis-ci.com/harryscholes/RomanNumerals.jl.svg?branch=master)](https://travis-ci.com/harryscholes/RomanNumerals.jl)
[![Codecov](https://codecov.io/gh/harryscholes/RomanNumerals.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/harryscholes/RomanNumerals.jl)
[![Coveralls](https://coveralls.io/repos/github/harryscholes/RomanNumerals.jl/badge.svg?branch=master)](https://coveralls.io/github/harryscholes/RomanNumerals.jl?branch=master)

Julia package for Roman numerals.

# Installation

```julia
] add https://github.com/harryscholes/RomanNumerals.jl
```

# Examples

```julia
julia> using RomanNumerals

julia> foreach(i->println(RomanNumeral(i)), 1:5)
I
II
III
IV
V

julia> I + I
II

julia> V - I
IV

julia> 3X - 2I
XXVIII

julia> M ÷ X
C

julia> rand(RomanNumeral, 5)
5-element Array{RomanNumeral,1}:
 LXXI  
 CXX   
 XCVIII
 XLIX  
 VIII

julia> RomanNumeral(2019)
MMXIX

julia> Int16(rn"MMXIX")
2019

julia> rn"I" == RomanNumeral("I") == RomanNumeral('I') == RomanNumeral(1)
true
```
