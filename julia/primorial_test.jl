# $Id$

include("cc.jl")
include("primorial.jl")

function s_factor_cc_primorial(n; kind=1)
    (a,q) = Primorials.factor_cc_primorial(n, kind=kind)
    s = ""
    if a > 1
      s *= string(a)
      s *= "*"
    end
    s *= string(q)
    s *= "#"
    if kind == 1
      s *= "-1"
    else
      s *= "+1"
    end
end

function s_factor_cc(n; kind=1, space=false)
    f = Primorials.factor_cc(n,kind=kind)
    s = ""
    for p in keys(f)
      if length(s) > 0
        if space
          s *= " "
        end
        s *= "*"
        if space
          s *= " "
        end
      end
      s *= string(p)
      k = f[p]
      if k > 1
        s *= ("^" * string(k))
      end
    end
    if space
      s *= " "
    end
    if kind == 1
      s *= "-1"
    else
      s *= "+1"
    end
    return s
end

function print_primorial(n)
    s1 = s_factor_cc_primorial(n)
    s2 = s_factor_cc(n)
    println("$(n) ($(s1)) ($(s2)) $(ndigits(n)) $(CunninghamChains.cunningham_chain(n,kind=1,check=false))")
end

Base.@ccallable function julia_main()::Cint
  print_primorial(91304653283578934559359)
  print_primorial(2759832934171386593519)
  print_primorial(892390227741617675069)
  print_primorial(810433818265726529159)
  print_primorial(90616211958465842219)
  return 0
end

if abspath(PROGRAM_FILE) == @__FILE__
  julia_main()
end
