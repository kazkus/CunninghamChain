# $Id$

using Primes
using Base.Threads
using Dates
using Printf

function cunningham_chain(p)
  q = convert(Int64,p)
  n = 1
  while isprime(2q+1)
    q = 2q+1
    n += 1
  end
  return n
end

function cunningham_chains_count(lo,hi)
  c = zeros(Int64, 9)
  for p in primes(lo,hi)
    n = cunningham_chain(p)
    c[n] += 1
  end
  return c
end

function dl()
  for d in 1:9
    c = cunningham_chains_count(10^(d-1)+1,10^d)
    println("$(d) : $(c)")
  end
end

Base.@ccallable function julia_main()::Cint
  dl()
  return 0
end

if abspath(PROGRAM_FILE) == @__FILE__
  julia_main()
end
