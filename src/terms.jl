baremodule Domain
    const Optimization = :Optimization
    const Statistics = :Statistics
end

type Term
    domain::Symbol
    description::String
    standard_name::Symbol
    alternative_names::Array{Symbol,1}
end

terms = Term[]
addterm(x) = begin push!(terms, x); x end

macro term(domain, desc, name, altnames)
    :( addterm( Term($domain, $desc, $name, $altnames) ) )
end
