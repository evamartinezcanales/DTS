"""
    trim(t, v) → (tt,tv)

A function to trim away the zeros of a value vector 
on the left and the right, and co-indexed time scale.
This prevents non-info from appearing in time-value pairs.

Use example: 
```julia
(trimmedt, trimmedv) = trim(t,v)
```  
"""

function trim(t::Vector,v::Vector)#precondition both have the same length
    L = length(v);
    @assert length(t) == length(v)#fail otherwise.
    s = findfirst(!isequal(0.0), v)
    e = findlast(!isequal(0.0), v)
    return (isnothing(s) ? (Vector{Integer}(),zeros(0)) : (t[s:e], v[s:e]))
end



"""
    create(n,v) 
    
A function to create a signal with time index n and values v
"""
function signal(n::Vector{Int64},  v::Vector{Complex{Float64}})::DataFrame
    #include the code here to create the signal
    @assert length(n) == length(v)
    nt,vt = trim(n,v)
    return DataFrame(;Time = nt, Value = vt)
end

n = collect(-3:3)
v = Vector{Complex{Float64}}(zeros(length(n)))
v[4] = 1.0

trim(n, v)

signal(n, v)

# 3. Create a function to visualise a signal, document it, test it, and store 
# it in signals.jl.
"""
    prototype

Documenting string here.
"""
function visualise!(s::DataFrame)
    stem!(s.Time,real.(s.Value))
end

f1 = Figure()
Axis(f1[1,1])
visualise!(x_n)
f1

