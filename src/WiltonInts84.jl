module WiltonInts84

export contour, wiltonints

include("contour.jl")

function segints!{N}(a, b, p, h, ::Type{Val{N}})

    @assert N ≥ 0
    T = typeof(a)

    h2, d = h^2, abs(h)
    q2 = p^2+h2
    ra, rb = sqrt(a^2+q2), sqrt(b^2+q2)

    I = zeros(T, N+3)
    K = zeros(T, N+3)
    J = zeros(T, 2)

    # n = -3
    if p == 0
        I[1] = 0
    else
        I[1] = sign(h)*(atan((p*b)/(q2+d*rb)) - atan((p*a)/(q2 + d*ra)))
    end # I_{-3}
    if q2 == zero(typeof(q2))
        J[1] = (b > 0) ? log(b/a) : log(a/b)
    else
        J[1] = log(b + rb) - log(a + ra)
    end # J_{-1}
    K[1] = -J[1] # K_{-3}

    # n = -1
    I[2] = p*J[1] - h*I[1]
    J[1] = (b*rb - a*ra + q2*J[1])/2 # J_1
    K[2] = J[1]

    # n = 0
    I[3] = (b*p - a*p)/2
    J[2] = ((b*(b^2+q2)+2*q2*b) - (a*(a^2+q2)+2*q2*a))/3 # J_2
    K[3] = J[2]/2

    # n >= 1
    for i in 4 : length(I)
        n = i - 3; j = mod1(n,2)
        I[i] = p/(n+2)*J[j] + n/(n+2)*h2*I[i-2]
        J[j] = (b*rb^(n+2) - a*ra^(n+2) + (n+2)*q2*J[j])/(n+3)
        K[i] = J[j]/(n+2)
    end

    return I, K
end


function arcints!{N}(α, m, p, h, ::Type{Val{N}})

    T = typeof(h)
    P = typeof(m)

    A = Vector{T}(N+3)
    B = Vector{P}(N+3)

    h2 = h^2
    p2 = p^2
    q2 = h2 + p2
    q = sqrt(q2)
    d = sqrt(h2)

    # n == -3
    A[1] = -α * (h/q - sign(h))
    B[1] = -p / q * m

    # n == -1
    A[2] = α * (q - d)
    B[2] = p * q * m

    # n == 0
    A[3] = α * p2 / 2
    B[3] = p * q2 / 2 * m

    for i in 4:length(A)
        n = i-3
        A[i] = α * ((n*A[i-2]/α + d^n)*q2 - d^(n+2)) / (n+2)
        B[i] = p * q^(n+2) * m / (n+2)
    end

    return A, B
end


function circleints!{N}(σ, p, h, ::Type{Val{N}})

    T = typeof(h)
    A = Vector{T}(N+3)

    h2 = h^2
    p2 = p^2
    q2 = h2 + p2
    q = sqrt(q2)
    d = sqrt(h2)
    α = σ * 2π

    # n == -3
    A[1] = -α * (h/q - sign(h))

    # n == -1
    A[2] = α * (q - d)

    # n == 0
    A[3] = α * p2 / 2

    for i in 4:length(A)
        n = i-3
        A[i] = α * ((n*A[i-2]/α + d^n)*q2 - d^(n+2)) / (n+2)
    end

    return A
end


"""
    angle(p,q)

Returns the positive angle in [0,π] between p and q
"""
function angle(p,q)
    cs = dot(p,q) / norm(p) / norm(q)
    cs = clamp(cs, -1, +1)
    return acos(cs)
end


function wiltonints{N}(ctr, x, UB::Type{Val{N}})

    n = ctr.normal
    h = ctr.height

    ξ = x - h*n

    I = zeros(eltype(x), N+3)
    K = zeros(typeof(x), N+3)

    # segments contributions
    for i in eachindex(ctr.segments)
        a = ctr.segments[i][1]
        b = ctr.segments[i][2]
        t = b - a
        t /= norm(t)
        m = cross(t, n)
        p = dot(a-ξ,m)
        sa = dot(a-ξ,t)
        sb = dot(b-ξ,t)
        P,Q = segints!(sa, sb, p, h, UB)
        for j in eachindex(I) I[j] += P[j]   end
        for j in eachindex(K) K[j] += Q[j]*m end
    end

    # arc contributions
    for i in eachindex(ctr.arcs)
        a = ctr.arcs[i][1]
        b = ctr.arcs[i][2]
        σ = ctr.arcs[i][3]
        p = σ > 0 ? ctr.plane_outer_radius : ctr.plane_inner_radius
        u1 = (a - ξ) / p
        u2 = σ * (n × u1)
        ξb = b - ξ
        α = dot(ξb,u2) >= 0 ? σ*angle(ξb,u1) : σ*(angle(ξb,-u1) + π)
        m = (sin(α)*u1 + σ*(1-cos(α))*u2)
        P, Q = arcints!(α, m, p, h, UB)
        I .+= P
        K .+= Q
    end

    # circle contributions
    for i in eachindex(ctr.circles)
        σ = ctr.circles[i]
        p = σ > 0 ? ctr.plane_outer_radius : ctr.plane_inner_radius
        P = circleints!(σ, p, h, UB)
        I .+= P
    end

    return I, K
end

function wiltonints{N}(p1,p2,p3,x,r,R,VN::Type{Val{N}})
    ctr = contour(p1,p2,p3,x,r,R)
    wiltonints(ctr,x,VN)
end

function wiltonints{N}(p1,p2,p3,x,VN::Type{Val{N}})
    ctr = contour(p1,p2,p3,x)
    wiltonints(ctr,x,VN)
end




end # module
