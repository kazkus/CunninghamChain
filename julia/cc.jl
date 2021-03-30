# $Id$

module CunninghamChains
export cunningham_chain, ndigits, cunn

using Primes

function cunningham_chain(p; kind=1, check=true)
    q = convert(Int128,p)
    n = Int8(0)
    while
      if check && !isprime(q)
        break
      else
        check = true
      end
      # kind==1 -> 2q+1, kind==2-> 2q-1
      q = 2*q-2*kind+3
      n += 1
    end
    return n
end

cunn(p) = cunningham_chain(p,kind=1,check=false)

ndigits(n) = length(digits(n))

end # module CunninghamChains
