pkg = "GtkIDE"

extension(f::AbstractString) = splitext(f)[2]

function checkpg(pgk::String, term::Term)

    n_standard = 0
    n_alt = zeros(Int,length(term.alternative_names))
    
    for (root, dirs, files) in walkdir( joinpath(Pkg.dir(pkg),"src")  ) 
        for file in files
            if extension(file) == ".jl"
                f = joinpath(root, file)
                println(f)
                sleep(0.01)
                str = readall(f)
                file_symbols = parsefile(str)
                
                n_standard += sum( file_symbols .== symbol(term.standard_name) )
                for i = 1:length(n_alt)
                    n_alt[i] += sum( file_symbols .== symbol(term.alternative_names[i]) )
                end
            end
        end
    end
    (n_standard, n_alt)
end

@time checkpg("GtkIDE",term)

## parsing file -> array of symbols

function parsefile(str)

    sym = Symbol[]
    i = start(str)
    while !done(str,i)
        try
            ex,i = parse(str,i)
            push!(sym,symbols(ex)...)
        catch err
#            @show err
        end
    end
    sym
end


## collecting symbols from expression

function symbols(ex::Expr)
    out = Symbol[]
    for child in ex.args
        s = symbols(child) 
        collect_symbols!(out,s)
    end
    out
end

symbols(s::Symbol) = s
# If we get anything else we return and empty array
symbols(s::Any) = Symbol[]

# If we got a symbol we add it to the output
collect_symbols!(out,s::Symbol) = push!(out,s)
# If we got an array of symbol we splice it to output (so we don't get array of array of array...)
collect_symbols!(out,s::Array{Symbol,1}) = push!(out,s...)


