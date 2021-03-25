# $Id$

using Primes
using Printf
using JLD

prime_list = primes(3,10^10)

function c(k)
    a = 1
    for p in prime_list
        if p <= k
            continue
        end
        a *= (1-k/p)
        a /= (1-1/p)^k
        #println("$(p) $(a)")
    end
    return a
end

function julia_main()
    C = [1.0]
    @printf("%2d %21.10f\n", 1, 1.0)
    for k in 2:20
        a = c(k)
        @printf("%2d %21.10f\n", k, a)
        push!(C, a)
    end
    #
    save("data/hwc.jld", "C", C)
end

if abspath(PROGRAM_FILE) == @__FILE__
    julia_main()
end

