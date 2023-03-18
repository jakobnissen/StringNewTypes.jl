module StringNewTypes

export @newtype

macro newtype(name)
    esc(
        quote
            struct $name
                x::String
            end
            String(x::$name) = x.x
            Base.hash(x::$name, h::UInt) = hash(x.x, xor(h, $(hash(String(name)))))
            Base.print(io::IO, x::$name) = print(io, x.x)
        end
    )
end

end # module StringNewTypes
