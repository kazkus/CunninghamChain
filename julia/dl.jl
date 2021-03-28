# $Id$

using Primes
using Base.Threads
using Dates
using Printf

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
    q = 2q-2*kind+3
    n += 1
  end
  return n
end

function cunningham_chains_count(lo,hi; kind=1)
  c = zeros(Int64, 10)
  for p in primes(lo,hi)
    n = cunningham_chain(p, kind=kind, check=false)
    c[n] += 1
  end
  return c
end

function dl09(; kind=1)
  out = open("data/dl"*string(kind)*".csv", "a")
  write(out, "d,l,c\n")
  for d in 1:9
    c = cunningham_chains_count(10^(d-1)+1,10^d, kind=kind)
    println("$(d) : $(c)")
    for l in 1:9
      if c[l] > 0
        write(out, "$(d),$(l),$(c[l])\n")
      end
    end
  end
  close(out)
end

function dl10(d; kind=1)
  lo_start = 10^(d-1)+1
  hi_end = 10^d
  lo_hi_len = 10^9
  n = div(hi_end - lo_start + 1, lo_hi_len)
  cc = zeros(Int64, 10)
  for lo in lo_start:lo_hi_len:hi_end
    hi = lo + lo_hi_len - 1
    c = cunningham_chains_count(lo,hi, kind=kind)
    println("$(lo) $(hi) : $(c)")
    cc .+= c
  end
  println("$(lo_start) $(hi_end) : $(cc)")
  out = open("data/dl"*string(kind)*".csv", "a")
  for l in 1:10
    write(out, "$(d),$(l),$(cc[l])\n")
  end
  close(out)
end

Base.@ccallable function julia_main()::Cint
  kind = 1
  d = 9
  if length(ARGS) > 0
    kind = parse(Int, ARGS[1])
    if length(ARGS) > 1
      d = parse(Int, ARGS[2])
    end
  end
  println("$(length(ARGS)) $(kind) $(d)")
  if d == 9
    dl09(kind=kind)
  else
    dl10(d, kind=kind)
  end
  return 0
end

if abspath(PROGRAM_FILE) == @__FILE__
  julia_main()
end
