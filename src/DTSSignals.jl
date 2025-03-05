"""
    Signals (version 0.0.1) --- An in-house module for signals.

    Author: FVA, all rights reserved 

"""
module Signals

import Base: *, +, conj

using Reexport
@reexport using DataFrames, CairoMakie

export Signal, 
    *, #dot product of signals, scalar product with a signal (inline)
    +, # addition of signals (inline)
    conj, #signal conjugate
    shift, # a function to shift a signal. 
    δ, # A primitive to generate a delta
    trim, # the function to trim values and time domains. 
    visualize!, #a function to visualize signals 
    isSignal #A predicate to check if something is a signal.

include("proto_signals.jl")

end# Module Signals
