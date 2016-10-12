baremodule Domain
    const Optimization = :Optimization
    const Statistics = :Statistics
end

type Term
    domain
    description
    standard_name
    alternative_names
end

terms = Term[]
addterm(x) = push!(terms, x)

macro term(domain, desc, name, altnames)
    :( addterm( Term($domain, $desc, $name, $altnames) ) )
end

@term Domain.Optimization "Absolute tolerance" "abstol" ["atol","abs_tol"]

@term Domain.Optimization "SolidString" "SolidString" ["SolidString_","abs_tol"]