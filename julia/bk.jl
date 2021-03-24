# $Id$

using Primes
using Printf

function ord(n,a)
    k = 1
    b = a
    while b != 1
        k += 1
        b = (b*a)%n
    end
    return k
end

function min_k_ord_p_2(p,k)
    if p > 2^k
        return k
    end
    # return min(k, ord(p,2))
    m = 1
    a = 2
    while a != 1
        m += 1
        if m > k
            return k
        end
        a = (a*2)%p
    end
    return m
end

odd_prime_list = primes(3,10^8)

function b(k)
    a = 2^(k-1)
    for p in odd_prime_list
        a *= (1-min_k_ord_p_2(p,k)/p)
        a /= (1-1/p)^k
        #println("$(p) $(a)")
    end
    return a
end

function julia_main()
    B = [1.0]
    @printf("%2d %21.10f\n", 1, 1.0)
    for k in 2:20
        a = b(k)
        # println("$(k) $(a)")
        @printf("%2d %21.10f\n", k, a)
        push!(B, a)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
  julia_main()
end

