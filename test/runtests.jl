using RomanNumerals
using Test
using Random

const MT = MersenneTwister

using RomanNumerals: InvalidRomanNumeral

@testset "Construction" begin
    @test RomanNumeral("I") == RomanNumeral(1)
    @test RomanNumeral("V") == RomanNumeral(5)
    @test RomanNumeral("X") == RomanNumeral(10)
    @test RomanNumeral("L") == RomanNumeral(50)
    @test RomanNumeral("C") == RomanNumeral(100)
    @test RomanNumeral("D") == RomanNumeral(500)
    @test RomanNumeral("M") == RomanNumeral(1000)

    @test RomanNumeral("II") == RomanNumeral(2)
    @test RomanNumeral("VII") == RomanNumeral(7)
    @test RomanNumeral("XXX") == RomanNumeral(30)
    @test RomanNumeral("LXIV") == RomanNumeral(64)
    @test RomanNumeral("CCL") == RomanNumeral(250)
    @test RomanNumeral("CD") == RomanNumeral(400)
    @test RomanNumeral("M") == RomanNumeral(1000)

    @test rn"I" == RomanNumeral(1)
    @test rn"V" == RomanNumeral(5)
    @test rn"X" == RomanNumeral(10)
    @test rn"L" == RomanNumeral(50)
    @test rn"C" == RomanNumeral(100)
    @test rn"D" == RomanNumeral(500)
    @test rn"M" == RomanNumeral(1000)

    @test rn"MMMCDLIII" == RomanNumeral(3453)
    @test rn"MCDXLIX" == RomanNumeral(1449)
    @test rn"MMMCMXCIV" == RomanNumeral(3994)
    @test rn"CCCCXXXXIIII" == rn"CDXLIV" == RomanNumeral(444)

    @test_throws InvalidRomanNumeral RomanNumeral("Y")
    @test_throws InvalidRomanNumeral RomanNumeral("XY")
end

@testset "Consts" begin
    @test I == RomanNumeral(1)
    @test V == RomanNumeral(5)
    @test X == RomanNumeral(10)
    @test L == RomanNumeral(50)
    @test C == RomanNumeral(100)
    @test D == RomanNumeral(500)
    @test M == RomanNumeral(1000)
end

@testset "Conversion" begin
    @testset "Integer" begin
        @test Int(rn"I") == 1
        @test Int8(rn"V") == 5
        @test Int16(rn"X") == 10
        @test Int32(rn"L") == 50
        @test Int64(rn"C") == 100
        @test Int16(rn"D") == 500
        @test Int32(rn"M") == 1000
    end
    @testset "String" begin
        @test string(rn"I") == "I"
        @test string(rn"V") == "V"
        @test string(rn"X") == "X"
        @test string(rn"L") == "L"
        @test string(rn"C") == "C"
        @test string(rn"D") == "D"
        @test string(rn"M") == "M"
    end
end

@testset "Arithmetic" begin
    @testset "Multiplication/Division" begin
        @test rn"II" == 2I == RomanNumeral(2)
        @test rn"III" == 3I == RomanNumeral(3)
        @test rn"IV" == 4I == RomanNumeral(4)
        @test rn"IX" == 9I == RomanNumeral(9)
        @test rn"XX" == 2X == RomanNumeral(20)
        @test rn"CCC" == 3C == RomanNumeral(300)
        @test rn"MMMM" == 4M == RomanNumeral(4000)

        @test I ÷ I == RomanNumeral(1)
        @test X ÷ V == RomanNumeral(2)
        @test L ÷ X == V
        @test C ÷ L == 2I
        @test C ÷ V == 2I * X
        @test M ÷ L == X + X
    end
    @testset "Addition/Subtraction" begin
        @test I + I == RomanNumeral(2)
        @test I + I + I == RomanNumeral(3)
        @test V - I == RomanNumeral(4)
        @test X - I == RomanNumeral(9)
        @test X + X == RomanNumeral(20)
        @test D - 2C == RomanNumeral(300)
        @test M + M + M + M == RomanNumeral(4000)
    end
end

@testset "Random" begin
    @test rand(MT(1), RomanNumeral) == rn"LXXXII"
    @test rand(MT(1), RomanNumeral, 3) == RomanNumeral.(["LXXXII","CXXVI","CIII"])
    @test rand(MT(2), RomanNumeral, 3) == RomanNumeral.(["CXXVI","XXXIII","XIX"])
end
