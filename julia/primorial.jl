# $Id$

module Primorials
export primorial, factor_cc

using Primes

function primorial(q)
    # return prod(primes(2,q))
    a = Int128(1)
    for p in primes(2,q)
        a *= p
    end
    return a
end

function factor_cc(n; kind=1)
    if kind == 1
      n += 1
    else
      n -= 1
    end
    return factor(n)
end

end # module
