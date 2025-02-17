# 0.Review exercises 0-3 in lab assignment 1 to create a script called lab1_script2.jl 
# that uses: DrWatson, CairoMakie and DataFrames, **from this skeleton**. 
using DrWatson
@quickactivate "labDTS24_25_emc"#Supply your initials
using DataFrames, CairoMakie

# 1. Check with intro.jl how to import code from the src directory into your scripts and
# create a signals.jl file in there. Put the following markup and code into it. Then 
# copy the way to include this code in the script from intro.jl
# 

include(srcdir("signals.jl"))

# Learned Outcome (LO): learned to include code in scripts. 
#   LO: learned how to write documentation for Julia functions. 
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


# 2. Read, understand and include in signals.jl the next function 
# to create signals 
#
#    (LO): learned to represent discrete time signals.

"""
    create(n,v) 
    
A function to create a signal with time index n and values v
"""


#trim(n, v; doTrim = false)
#doTrim is wrong bc it is not the way to define a keyword in Julia

# 3. Create a function to visualise a signal, document it, test it, and store 
# it in signals.jl.

"""
    prototype

Documenting string here.
"""

# 4. Define two primitives to represent a delta at the origin and a parametric complex 
# exponential over a closed (-pi, pi) interval. Include these primitives into your s
# rc/signals.jl file
#
#   Previous question: What are the parameters for a complex exponential in discrete time?
#
#   Question: how would you define a zero signal so that x + 0 = 0 + x = x, for every 
#   signal x?
#
#   LO: obtained representations for the two basic signals in discrete time. 

# 5. Using the previous representation of signals, define, primitives "sum", "scale", 
# "delay", "dot" (multiplication) that implement the algebra of signals, and include
# them in signals.jl
#
# LO: built an algebra to operate on signals.

# 5. Using the previously defined primitives, build the signal that is one period of the
# periodical signal in problem 6.4 of the Signals & Systems book. 
#
# LO: learned how to represent signals over time.

# The following should always appear in well-documented versions of your code: it is
# and indication of how your environment was built. 
Pkg.status()