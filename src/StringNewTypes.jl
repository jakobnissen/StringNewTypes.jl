module StringNewTypes

export @newtype

macro newtype(name)
    esc(newtype_internal(name))
end

function newtype_internal(name::Symbol)
    quote
        struct $name
            x::String
        end
        String(x::$name) = x.x
        Base.hash(x::$name, h::UInt) = hash(x.x, xor(h, $(hash_seed(String(name)))))
        Base.print(io::IO, x::$name) = print(io, x.x)
    end
end

function hash_seed(str::String)
    ones = 0x0101010101010101 % UInt
    seed = 0x88cb6ba2dfe5802f % UInt
    for byte in codeunits(str)
        seed = xor((byte * ones), bitrotate(seed, 17))
    end
    seed
end

end # module StringNewTypes
