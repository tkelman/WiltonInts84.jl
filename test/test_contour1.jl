using WiltonInts84

using Base.Test
using FixedSizeArrays

include("num_quad.jl")

if !isdefined(:record)
    record = false
end

p1 = Vec(1.0, 0.0, 0.0)
p2 = Vec(0.0, 1.0, 0.0)
p3 = Vec(0.0, 0.0, 0.0)
z  = Vec(0.0,0.0,1.0)


N = 2
T = eltype(Float64)
P = Vec{3,T}
J = Vector{Vec{N+3,T}}()
L = Vector{Vec{N+3,P}}()
I = similar(J)
K = similar(L)

h = 1.2


# code 01 and 00
c = p3
r, R = 0.1, 1.1
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p1,p2,p3,c,r,R)
@test length(q.segments) == 3
@test length(q.arcs) == 1
@test length(q.circles) == 0
ctr = contour(p1,p2,p3,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p1,p2,p3,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end
#error("stop")

# code 02
c = (p1+p2+p3)/3
r, R = 0.35, 200.0
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p1,p2,p3,c,r,R)
@test length(q.segments) == 6
@test length(q.arcs) == 3
@test length(q.circles) == 0
ctr = contour(p1,p2,p3,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p1,p2,p3,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end



# code 10
c = (p1+p2+p3)/3
r, R = 0.1, 0.49
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p1,p2,p3,c,r,R)
@test length(q.segments) == 3
@test length(q.arcs) == 2
@test length(q.circles) == 1
ctr = contour(p1,p2,p3,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p1,p2,p3,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end



# code 11
c = p3
r, R = 0.1, 0.3
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p1,p2,p3,c,r,R)
@test length(q.segments) == 2
@test length(q.arcs) == 2
@test length(q.circles) == 0
ctr = contour(p1,p2,p3,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p1,p2,p3,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end


# code 12
c = Vec(0.25,0.1,0.0)
r, R = 0.2, 0.3
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p1,p2,p3,c,r,R)
@test length(q.segments) == 3
@test length(q.arcs) == 2
@test length(q.circles) == 0
ctr = contour(p1,p2,p3,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p1,p2,p3,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end


c = Vec(0.1,0.25,0.0)
r, R = 0.2, 0.3
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p1,p2,p3,c,r,R)
@test length(q.segments) == 3
@test length(q.arcs) == 2
@test length(q.circles) == 0
ctr = contour(p1,p2,p3,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p1,p2,p3,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end


c = Vec(0.15,0.15,0.0)
r, R = 0.2, 0.3
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p1,p2,p3,c,r,R)
@test length(q.segments) == 4
@test length(q.arcs) == 3
@test length(q.circles) == 0
ctr = contour(p1,p2,p3,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p1,p2,p3,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end


# code 20
c = p3
r, R = 0.1, 0.9
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p1,p2,p3,c,r,R)
@test length(q.segments) == 3
@test length(q.arcs) == 3
@test length(q.circles) == 0
ctr = contour(p1,p2,p3,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p1,p2,p3,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end


c = (p1+p2+p3)/3
r, R = 0.1, 0.45
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p1,p2,p3,c,r,R)
@test length(q.segments) == 3
@test length(q.arcs) == 3
@test length(q.circles) == 1
ctr = contour(p1,p2,p3,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p1,p2,p3,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end


# code 21 is impossible

# code 22
c = (p1+p2+p3)/3
r, R = 0.35, 0.45
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p1,p2,p3,c,r,R)
@test length(q.segments) == 6
@test length(q.arcs) == 6
@test length(q.circles) == 0
ctr = contour(p1,p2,p3,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p1,p2,p3,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end



# cover the remaining arc configurations
c = (p1+p2+p3)/3
r, R = 0.5, 0.6
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p3,p1,p2,c,r,R)
@test length(q.segments) == 4
@test length(q.arcs) == 4
@test length(q.circles) == 0
ctr = contour(p3,p1,p2,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p3,p1,p2,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end


c = (p1+p2+p3)/3
r, R = 0.5, 0.6
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p2,p3,p1,c,r,R)
@test length(q.segments) == 4
@test length(q.arcs) == 4
@test length(q.circles) == 0
ctr = contour(p2,p3,p1,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p2,p3,p1,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end


c = (p1+p2+p3)/3
r, R = 0.5, 0.6
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p3,p1,p2,c,r,R)
@test length(q.segments) == 4
@test length(q.arcs) == 4
@test length(q.circles) == 0
ctr = contour(p3,p1,p2,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p3,p1,p2,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end


c = (p1+p2+p3)/3
r, R = 0.5, 0.6
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p1,p3,p2,c,r,R)
@test length(q.segments) == 4
@test length(q.arcs) == 4
@test length(q.circles) == 0
ctr = contour(p1,p3,p2,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p1,p3,p2,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end


# remaining circle case
c = (p1+p2+p3)/3
r, R = 0.1, 0.2
c += Vec(0,0,h)
r, R = sqrt(r^2+h^2), sqrt(R^2+h^2)
q = contour(p1,p2,p3,c,r,R)
@test length(q.segments) == 0
@test length(q.arcs) == 0
@test length(q.circles) == 2
ctr = contour(p1,p3,p2,c,r,R)
A,B = wiltonints(ctr,c, Val{N})
push!(I,A); push!(K,B)
if record
    P,Q = dblquadints1(p1,p3,p2,c,Val{N},r,R)
    push!(J,P); push!(L,Q)
end


using JLD
fn = joinpath(dirname(@__FILE__),"dblquad1.jld")

# convert data to Julia data type
I = [I[m][n] for m in eachindex(I), n in 1:length(eltype(I))]
K = [K[m][n][p] for m in eachindex(K), n in 1:length(eltype(K)), p in 1:3]

if record == true
    J = [J[m][n] for m in eachindex(J), n in 1:length(eltype(J))]
    L = [L[m][n][p] for m in eachindex(L), n in 1:length(eltype(L)), p in 1:3]
    jldopen(fn,"w") do file
        write(file, "J", J)
        write(file, "L", L)
    end
else
    J,L = jldopen(fn,"r") do file
        read(file, "J"), read(file, "L")
    end
end

@test maximum(I-J) < 1.0e-5
@test maximum(K-L) < 1.0e-5
