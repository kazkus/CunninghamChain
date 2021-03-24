# $Id$

using Primes
using Printf
using JLD

function ord(n,a; k=0)
    m = 1
    b = a
    while b != 1
        m += 1
        if k > 0 && m > k
            return k
        end
        b = (b*a)%n
    end
    return m
end

function min_k_ord_p_2(p,k)
    if p > 2^k
        return k
    end
    return min(k, ord(p,2, k=k))
end

# odd_prime_list = primes(3,10^8)
# odd_prime_list = primes(3,10^9)
odd_prime_list = primes(3,10^10)

function b(k)
    a = 2^(k-1)
    for p in odd_prime_list
        a *= (1-min_k_ord_p_2(p,k)/p)
        a /= (1-1/p)^k
    end
    return a
end

function julia_main()
    B = [1.0]
    @printf("%2d %21.10f\n", 1, 1.0)
    for k in 2:20
        a = b(k)
        @printf("%2d %21.10f\n", k, a)
        push!(B, a)
    end
    #
    save("data/bk.jld", "Bk", B)
end

if abspath(PROGRAM_FILE) == @__FILE__
    julia_main()
end

