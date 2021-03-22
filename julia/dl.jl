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

function dl09()
  out = open("data/dl.csv", "w")
  write(out, "d,l,c\n")
  for d in 1:9
    c = cunningham_chains_count(10^(d-1)+1,10^d)
    println("$(d) : $(c)")
    for l in 1:9
      write(out, "$(d),$(l),$(c[l])\n")
    end
  end
  close(out)
end

function dl10()
  d = 10
  lo_start = 10^(d-1)+1
  hi_end = 10^d
  lo_hi_len = 10^9
  n = div(hi_end - lo_start + 1, lo_hi_len)
  cc = zeros(Int64, 9)
  for lo in lo_start:lo_hi_len:hi_end
    hi = lo + lo_hi_len - 1
    c = cunningham_chains_count(lo,hi)
    println("$(lo) $(hi) : $(c)")
    cc .+= c
  end
  println("$(lo_start) $(hi_end) : $(cc)")
  out = open("data/dl.csv", "a")
  for l in 1:9
    write(out, "$(d),$(l),$(cc[l])\n")
  end
  close(out)
end

Base.@ccallable function julia_main()::Cint
  dl09()
  # dl10()
  return 0
end

if abspath(PROGRAM_FILE) == @__FILE__
  julia_main()
end
