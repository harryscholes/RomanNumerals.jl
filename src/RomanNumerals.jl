module RomanNumerals

export
    RomanNumeral,
    @rn_str,
    I, V, X, L, C, D, M

import Base: +, -, *, ÷

"""
    RomanNumeral(num)

A type that represents a Roman numeral.

`RomanNumeral` objects can be created using `Integer` or `AbstractString` objects, or using
the `@rn_str` string macro.

# Examples

```jldoctest
julia> using RomanNumerals

julia> RomanNumeral(1)
I

julia> RomanNumeral(5)
V

julia> RomanNumeral(9)
IX

julia> RomanNumeral(2019)
MMXIX

```

# String literal

```jldoctest
julia> rn"MMXIX"
MMXIX

```

# Arithmetic

```jldoctest
julia> I + I
II

julia> V - I
IV

julia> 3X - 2I
XXVIII

julia> M ÷ X
C

```

# Conversion

```jldoctest
julia> Int(rn"MMXIX")
2019

julia> string(rn"MMXIX")
"MMXIX"

```
"""
struct RomanNumeral{T<:Integer}
    num::T

    function RomanNumeral(num::T) where T<:Integer
        num ≤ 0 && throw(DomainError("Roman numerals must be positive"))
        new{T}(num)
    end
end

RomanNumeral(rn::AbstractString) = convert(RomanNumeral, rn)

# I, V, X, L, C, D and M consts

for (rn,v) = [(:I,1), (:V,5), (:X,10), (:L,50), (:C,100), (:D,500), (:M,1000)]
    @eval begin
        """
            $($rn)

        The Roman numeral for $($v).
        """
        const $rn = RomanNumeral($v)
    end
end

const RomanNumeralChars = ['I', 'V', 'X', 'L', 'C', 'D', 'M']

# Arithmetic

for op = [:+, :-, :*, :÷]
    @eval begin
        ($op)(x::RomanNumeral, y::RomanNumeral) = RomanNumeral(($op)(x.num, y.num))
        ($op)(x::RomanNumeral, y::Integer) = RomanNumeral(($op)(x.num, y))
        ($op)(x::Integer, y::RomanNumeral) = RomanNumeral(($op)(x, y.num))
    end
end

# Parsing

const INT_NUMERAL = Dict(
    1    => "I",
    4    => "IV",
    5    => "V",
    9    => "IX",
    10   => "X",
    40   => "XL",
    50   => "L",
    90   => "XC",
    100  => "C",
    400  => "CD",
    500  => "D",
    900  => "CM",
    1000 => "M")

const NUMERAL_INT = Dict(zip(values(INT_NUMERAL), keys(INT_NUMERAL)))

const ROMAN_NUMERAL_REGEX =
    r"(M*(CM|CD|DC{0,4}|C{0,9})(XC|XL|LX{0,4}|X{0,9})(IX|IV|VI{0,4}|I{0,9}))"x

function isvalidromannumeral(rn::AbstractString)
    m = match(ROMAN_NUMERAL_REGEX, rn)
    isnothing(m) && throw(InvalidRomanNumeral())
    length(m.match) != length(rn) && throw(InvalidRomanNumeral())
    true
end

function Base.parse(::Type{String}, rn::RomanNumeral)
    x = rn.num
    s = ""
    for y = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        s *= repeat(INT_NUMERAL[y], x ÷ y)
        x %= y
    end
    s
end

function Base.parse(::Type{RomanNumeral}, rn::String)
    isvalidromannumeral(rn)
    x = 0
    curr = NUMERAL_INT[string(rn[1])]
    for i = 1:length(rn)-1
        next = NUMERAL_INT[string(rn[i+1])]
        curr < next ? (x -= curr) : (x += curr)
        curr = next
    end
    x += curr
    RomanNumeral(x)
end

Base.convert(::Type{String}, rn::RomanNumeral) = parse(String, rn)
Base.convert(::Type{RomanNumeral}, rn::String) = parse(RomanNumeral, rn)
Base.convert(::Type{T}, rn::RomanNumeral) where T<:Integer = T(rn.num)
Base.Int(rn::RomanNumeral) = convert(Int, rn)
Base.show(io::IO, rn::RomanNumeral) = print(io, convert(String, rn))

# String literal

"""
    rn"IVXLCDM"

RomanNumeral string literal.
"""
macro rn_str(rn)
    RomanNumeral(rn)
end

# Exceptions

struct InvalidRomanNumeral <: Exception end

Base.showerror(io::IO, e::InvalidRomanNumeral) = print(io, "InvalidRomanNumeral:")

end # module