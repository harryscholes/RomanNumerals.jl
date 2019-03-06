var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "#RomanNumerals.RomanNumeral",
    "page": "Home",
    "title": "RomanNumerals.RomanNumeral",
    "category": "type",
    "text": "RomanNumeral(num)\n\nA type that represents a Roman numeral.\n\nRomanNumeral objects can be created using Integer or AbstractString objects, or using the @rn_str string macro.\n\nExamples\n\njulia> using RomanNumerals\n\njulia> RomanNumeral(1)\nI\n\njulia> RomanNumeral(5)\nV\n\njulia> RomanNumeral(9)\nIX\n\njulia> RomanNumeral(2019)\nMMXIX\n\n\nString literal\n\njulia> rn\"MMXIX\"\nMMXIX\n\n\nArithmetic\n\njulia> I + I\nII\n\njulia> V - I\nIV\n\njulia> 3X - 2I\nXXVIII\n\njulia> M ÷ X\nC\n\n\nConversion\n\njulia> Int(rn\"MMXIX\")\n2019\n\njulia> string(rn\"MMXIX\")\n\"MMXIX\"\n\n\n\n\n\n\n"
},

{
    "location": "#RomanNumerals.@rn_str",
    "page": "Home",
    "title": "RomanNumerals.@rn_str",
    "category": "macro",
    "text": "rn\"IVXLCDM\"\n\nRomanNumeral string literal.\n\n\n\n\n\n"
},

{
    "location": "#RomanNumerals.I",
    "page": "Home",
    "title": "RomanNumerals.I",
    "category": "constant",
    "text": "I\n\nThe Roman numeral for 1.\n\n\n\n\n\n"
},

{
    "location": "#RomanNumerals.V",
    "page": "Home",
    "title": "RomanNumerals.V",
    "category": "constant",
    "text": "V\n\nThe Roman numeral for 5.\n\n\n\n\n\n"
},

{
    "location": "#RomanNumerals.X",
    "page": "Home",
    "title": "RomanNumerals.X",
    "category": "constant",
    "text": "X\n\nThe Roman numeral for 10.\n\n\n\n\n\n"
},

{
    "location": "#RomanNumerals.L",
    "page": "Home",
    "title": "RomanNumerals.L",
    "category": "constant",
    "text": "L\n\nThe Roman numeral for 50.\n\n\n\n\n\n"
},

{
    "location": "#RomanNumerals.C",
    "page": "Home",
    "title": "RomanNumerals.C",
    "category": "constant",
    "text": "C\n\nThe Roman numeral for 100.\n\n\n\n\n\n"
},

{
    "location": "#RomanNumerals.D",
    "page": "Home",
    "title": "RomanNumerals.D",
    "category": "constant",
    "text": "D\n\nThe Roman numeral for 500.\n\n\n\n\n\n"
},

{
    "location": "#RomanNumerals.M",
    "page": "Home",
    "title": "RomanNumerals.M",
    "category": "constant",
    "text": "M\n\nThe Roman numeral for 1000.\n\n\n\n\n\n"
},

{
    "location": "#RomanNumerals.jl-1",
    "page": "Home",
    "title": "RomanNumerals.jl",
    "category": "section",
    "text": "Julia package for Roman numerals.Modules = [RomanNumerals]\nOrder   = [:type, :macro, :constant]CurrentModule = RomanNumerals\nDocTestSetup = quote\n    using RomanNumerals\nendRomanNumeral\n@rn_str\nI\nV\nX\nL\nC\nD\nMDocTestSetup = nothing"
},

]}
