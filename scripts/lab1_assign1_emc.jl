# 0.Add the packages DrWatson, Revise and OhMyREPL to your environment.
#
# Recall Competence (RC): learn how to add packages to an environment.
incomplete() = throw("Unimplemented code!")

# 1. Create a directory for your practicals by using DrWatson (add it to your environment 
# if you haven't done so  yet) on the user of your choice a directory for practicals with 
# a name that follows (supply your initials there) "labDTS24_25_<lowercase_initials>"
#
#    Learning Outcome (LO): Learned how to create controlled experiments directories with DrWatson. 

# 2. Invoke VS Code and open the newly created folder (give it the trust attribute). Open 
# the README.md file and check that everything is to your liking, otherwise change it.
#
#   LO: learned how to use VS Code to open a folder and visualise the files there in.
   
# 3. Open the file scripts/intro.jl and run it. This is a good example of how to start 
# localising your scripts using DrWatson.
#   Note how running the script will open up the julia REPL automatically and notice how the intro activates your working environment using:
#   	> @quickactivate "labDTS24_25_<initials>"
#
#   LO: learned to activate your environment for each script with DrWatson.
#   LO: learned how to run code from VS Code.

# 4. Add the packages CairoMakie.jl and DataFrames.jl to the environment.
#
#   RC: learn how to activate an environment. 

# 5. Copy the scripts/intro.jl into scripts/lab1_1.jl.
#
#   LO: learned how to start a new script from intro.jl

# 6. Modify the lab1_1.jl script to use DataFrames and CairoMakie
using DataFrames, CairoMakie
#   RC: learn how to use packages in code.

# 7. Idem. to define a delta function in julia like:
function δ(n::Vector{})
    d = zeros(size(n));
   if any(n .== 0) #the dot is saying they have to do things component wise
         println("ok");
         d[n .== 0] .= 1.0;
   end
   return d
end
# LO: Learned how to define functions in julia

#8. Using CairoMakie, find the "stem" primitive (q.v.) and use it to represente a delta 
# function defined on a time axis from -3 to 3. 
# 
#   LO: learned how to define and plot delta functions at the origin.
n = collect(-3:3)
x = δ(n) 

begin
   f1 = Figure()
   Axis(f1[1,1])
   stem!(n,x)
   f1
end

# 8. Define two functions in julia, with two parameters, an amplification and a period N::Integer,
# defining amplified cosines and sines, respectively, and visualise them. 
function mycos(A::Real, N::Integer)
	 n = 0.0:(2pi/N):2pi; #means from 0 to 2pi in N steps
	 return (A .* cos.(n)) #means multiply each element of the array by A
end

function mysin(A::Real, N::Integer)
   n = 0.0:(2pi/N):2pi;
   return (A .* sin.(n))
end


# LO: learned how to define and plot sinusoidal functions. 

# 9. Change the labels of the time axis with CairoMakie so that it reads from 0 to 
# 2*pi in only pi/4 intervals. Hint: use ?xticks.

#   LO: Learned how to change the x label ticks. 

f2 = Figure()
Axis(f2[1,1], xticks = (0:pi/4:2pi, ["0", "π/4", "π/2", "3π/4", "π", "5π/4", "3π/2", "7π/4", "2π"]))
stem!(0.0:(2pi/27):2pi, mycos(1.0, 27))
Axis(f2[2,1], xticks = (0:pi/4:2pi, ["0", "π/4", "π/2", "3π/4", "π", "5π/4", "3π/2", "7π/4", "2π"]))
stem!(0.0:(2pi/27):2pi, mysin(1.0, 27))
f2

 
