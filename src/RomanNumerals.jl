module RomanNumerals

export
    RomanNumeral,
    @rn_str,
    I, V, X, L, C, D, M

import Base:
    +, -, *, ÷,
    Int8, Int16, Int32, Int64, Int128,
    BigInt,
    UInt8, UInt16, UInt32, UInt64, UInt128

using Random

const MAXIMUM_ROMAN_NUMERAL = 5000

"""
    RomanNumeral(num)

A type that represents a Roman numeral.

`RomanNumeral` objects can be created using `Integer` or `AbstractString` objects, or using
the `@rn_str` string macro.

# Examples

```jldoctest
julia> using RomanNumerals

julia> foreach(i->println(RomanNumeral(i)), 1:5)
I
II
III
IV
V

julia> rand(RomanNumeral, 5)
5-element Array{RomanNumeral,1}:
 LXXI
 CXX
 XCVIII
 XLIX
 VIII

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
julia> RomanNumeral(2019)
MMXIX

julia> Int16(rn"MMXIX")
2019

julia> string(rn"MMXIX")
"MMXIX"

julia> rn"I" == RomanNumeral("I") == RomanNumeral('I') == RomanNumeral(1)
true
```
"""
struct RomanNumeral{T<:Integer}
    num::T

    function RomanNumeral{T}(num::T) where T<:Integer
        num ≤ 0 && throw(DomainError(num, "Roman numerals must be positive"))
        new{T}(num)
    end
end

RomanNumeral(num::T) where T<:Integer = RomanNumeral{T}(num)
RomanNumeral(rn::AbstractString) = parse(RomanNumeral, rn)
RomanNumeral(rn::AbstractChar) = parse(RomanNumeral, string(rn))

# I, V, X, L, C, D and M consts

for (rn, v) in (
    (:I,    1),
    (:V,    5),
    (:X,   10),
    (:L,   50),
    (:C,  100),
    (:D,  500),
    (:M, 1000),
)
    @eval begin
        """
            $($rn)

        The Roman numeral for $($v).
        """
        const $rn = RomanNumeral($v)
    end
end

const ROMAN_NUMERAL_CHARS = ('I', 'V', 'X', 'L', 'C', 'D', 'M')

# Arithmetic

for op in (
    :+,
    :-,
    :*,
    :÷,
)
    @eval begin
        ($op)(x::RomanNumeral, y::RomanNumeral) = RomanNumeral(($op)(x.num, y.num))
        ($op)(x::RomanNumeral, y::Integer) = RomanNumeral(($op)(x.num, y))
        ($op)(x::Integer, y::RomanNumeral) = RomanNumeral(($op)(x, y.num))
    end
end

# Parsing

const INT_NUMERAL = Dict(
       1 => "I",
       4 => "IV",
       5 => "V",
       9 => "IX",
      10 => "X",
      40 => "XL",
      50 => "L",
      90 => "XC",
     100 => "C",
     400 => "CD",
     500 => "D",
     900 => "CM",
    1000 => "M",
)

const NUMERAL_INT = Dict(
    zip(
        values(INT_NUMERAL),
        keys(INT_NUMERAL),
    )
)

const ROMAN_NUMERAL_REGEX =
    r"(M*(CM|CD|DC{0,4}|C{0,9})(XC|XL|LX{0,4}|X{0,9})(IX|IV|VI{0,4}|I{0,9}))"x

function is_valid_roman_numeral(rn::AbstractString)
    m = match(ROMAN_NUMERAL_REGEX, rn)
    isnothing(m) && throw(InvalidRomanNumeral())
    length(m.match) != length(rn) && throw(InvalidRomanNumeral())
    return true
end

function Base.parse(::Type{String}, rn::RomanNumeral)
    x = rn.num
    s = ""
    for y in (1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1)
        s *= repeat(INT_NUMERAL[y], x ÷ y)
        x %= y
    end
    return s
end

function Base.parse(::Type{RomanNumeral}, rn::String)
    is_valid_roman_numeral(rn)
    f = i -> NUMERAL_INT[string(rn[i])]
    x = 0
    curr = f(1)
    for i = 1:length(rn) - 1
        next = f(i + 1)
        if curr < next
            x -= curr
        else
            x += curr
        end
        curr = next
    end
    x += curr
    return RomanNumeral(x)
end

Base.convert(::Type{String}, rn::RomanNumeral) = parse(String, rn)
Base.convert(::Type{RomanNumeral}, rn::String) = parse(RomanNumeral, rn)
Base.convert(::Type{T}, rn::RomanNumeral) where T<:Integer = convert(T, rn.num)

for T in (
    :Int8, :Int16, :Int32, :Int64, :Int128,
    :BigInt,
    :UInt8, :UInt16, :UInt32, :UInt64, :UInt128,
)
    @eval $T(rn::RomanNumeral) = convert($T, rn)
end

Base.show(io::IO, rn::RomanNumeral) = print(io, convert(String, rn))

# Random numerals

function Random.rand(rng::AbstractRNG, ::Random.SamplerType{RomanNumeral{T}}) where T<:Integer
    max_num = min(typemax(T), MAXIMUM_ROMAN_NUMERAL)
    num = rand(rng, 1:max_num)
    return RomanNumeral(T(num))
end

function Random.rand(rng::AbstractRNG, ::Random.SamplerType{RomanNumeral})
    num = rand(rng, 1:MAXIMUM_ROMAN_NUMERAL)
    return RomanNumeral(num)
end

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
