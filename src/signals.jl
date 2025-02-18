using DataFrames
using CairoMakie

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
    return DataFrame(;Time = nt, Value = vt) #devuelve un dataframe(tabla con datos)
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

# 4. Define two primitives to represent a delta at the origin and a parametric complex 
# exponential over a closed (-pi, pi) interval.
function δ()
    n = collect(-3:3)  # Rango de índices
    v = zeros(ComplexF64, length(n))  # genera un vector de ceros de tipo ComplexF64 (números complejos con precisión de 64 bits)
    v[findfirst(isequal(0), n)] = 1.0  # Asigna 1 en n=0
    return signal(n, v) #convierte los vectores n y v en una tabla.
end



#n: Es un vector de tiempos o índices que define los instantes en los que se evalúa la señal.
#v: Es un vector de valores de la señal en los tiempos correspondientes a n

function exp_signal(A::Real, N::Integer) #A=amplitud y N=periodo
    n = round.(Int, collect(0.0:(2pi/N):2pi))  # Rango de índices, ponemos el round.(Int, ) para que sean enteros
    v = A .* exp.(1im .* n)  # Valores de la señal
    return signal(n, v)
end


function complex_exponential_signal(ω::Float64)
    n = round.(Int, collect(-π:0.1:π) ) # Valores en el intervalo (-π, π)
    v = exp.(im * ω * n)   # e^(jωn) para cada n
    return signal(n, v)
end


#sum of 2 signals
function sum(s1::DataFrame, s2::DataFrame)::DataFrame #El resultado será una nueva señal con los tiempos y valores de ambas señales en un solo DataFrame
    n = vcat(s1.Time, s2.Time)  # resultado es un vector n que contiene todos los tiempos de ambas señales 
    v = vcat(s1.Value, s2.Value)  # Merge values
    return signal(n, v) #la función signal(n, v), que toma los tiempos 
end  #n y los valores v concatenados y los convierte en un DataFrame con las columnas Time y Value

#s1.Time y s2.Time son los vectores de tiempo de las señales s1 y s2
#vcat toma ambos vectores de tiempo y los concatena verticalmente(uno debajo del otro)
#s1.Value y s2.Value son los vectores de valores de las señales s1 y s2, vacat los concatena verticalmente

#delay of a signal
function delay(s::DataFrame, d::Real)::DataFrame
    return signal(s.Time .+ d, s.Value)
end
#s::DataFrame --> señal 
#d::nº real que va a ser el desplazamiento 

#dot product 
function dot(s1::DataFrame, s2::DataFrame)::DataFrame #::DataFrame del final indica que la función devuelve un DataFrame
    common_times = intersect(s1.Time, s2.Time)  # Find common time indices
    v1 = [s1.Value[s1.Time .== t][1] for t in common_times]
    v2 = [s2.Value[s2.Time .== t][1] for t in common_times]
    return signal(common_times, v1 .* v2)
end
#Para cada t en common_times, buscamos el valor correspondiente en s1 y s2.
#s1.Value[s1.Time .== t] devuelve los valores en s1 cuyo tiempo es t.
#[1] extrae el primer valor (porque s1.Time .== t devuelve un subvector)

#creamos una funcion (señal) que sea deltas con un lenght predeterminado
function impulse(N0::Int)
    n = collect(-N0:N0)  # Rango de índices
    v = zeros(ComplexF64, length(n))  # crea un vector de ceros complejos de length = n
    v[N0 + 1] = 1.0  # Asigna 1 en n=0, N0 + 1 es el indice de n=0
    return signal(n, v)
end

# Create one period of the periodic signal x[n] 
function periodic_signal(N0::Int)
    δ = impulse(N0)  # δ[n]
    δ_delayed1 = delay(δ, 4)  # δ[n - 5]
    sum1 = sum(δ, δ_delayed1)
    δ_delayed2 = delay(δ, 3)  
    sum2 = sum(sum1, δ_delayed2)
    δ_delayed3 = delay(δ, 2)  
    sum3 = sum(sum2, δ_delayed3)
    δ_delayed4 = delay(δ, 1)  
    sum4 = sum(sum3, δ_delayed4)
    return sum4
end

#la señal x[n] es 5 deltas y 5 ceros periodicamente

