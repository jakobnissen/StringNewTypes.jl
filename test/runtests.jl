module TestStringNewTypes

using StringNewTypes
using Test

@newtype Foo
@newtype Bar

@testset "Errors" begin
    isempty(Set()) # bring these names into scope

    @test_throws Exception @eval @newtype Set
    @test_throws Exception @eval @newtype isempty

    @test_throws Exception @eval @newtype Symbol("1a")
    @test_throws Exception @eval @newtype Symbol("")
end

@testset "Behaviour" begin
    a = Foo("abc")
    b = Foo("abc")
    c = Foo(view("xabcy", 2:4))

    # Equal to itself, not strings, not other Foos
    @test a == b == c
    @test a != Foo("abx")
    @test a != "abc"

    # Convert to strings
    @test String(a) == "abc"
    @test string(a) == "abc"

    # Isequal and hash
    @test isequal(a, b)
    @test !isequal(a, Foo("abcd"))
    @test !isequal(a, "abc")
    @test hash(a) == hash(b) != hash("abc")
    @test hash(a) != hash(Foo("abcd"))

    # Difference from another newtype
    x = Bar("abc")
    @test a != x
    @test !isequal(a, x)
    @test hash(a) != hash(x)
    @test x == Bar("abc")
end

end # module
