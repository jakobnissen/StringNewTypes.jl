# StringNewTypes.jl

:warning:
    This package is not in the Julia General registry, because I'm not sure it's useful enough.
    It may be registered in the future, in which case the version from this repo will be deprecated.

StringNewTypes.jl exports a single macro, `@newtype`.
Calling `@newtype Foo` will define a new type `Foo`, which is a wrapper type around `String`.
The purpose of newtypes is to inform the type system of different "kind" of strings - for example, compare how easy it is to understand the purpose of the following line of code where different data is encoded as `String`:

* `viruses = Dict{String, Dict{String, Tuple{String, LongRNA{2}}}}()`

Versus one using newtypes:

* `viruses = Dict{Sample, Dict{Experiment, Tuple{Id, LongRNA{2}}}}()`

Currently, `@newtype Foo` defines the following
* The immutable struct `Foo`
* `String(::Foo)`
* Hashing, where the `Foo` type hashes uniquely, but nearly as efficient as `String`.
* Printing, where it prints like a string.

## Installation
In Julia's package mode, type: 
```julia
pkg> add https://github.com/jakobnissen/StringNewTypes.jl#master
```

## Usage
```julia
julia> using StringNewTypes

julia> @newtype Sample

julia> sample = Sample("abc")
Sample("abc")

julia> String(sample)
"abc"

julia> sample == "abc"
false

julia> println(sample)
abc

```
