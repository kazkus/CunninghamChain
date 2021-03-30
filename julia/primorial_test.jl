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

function print_primorial(n; kind=1)
    s1 = s_factor_cc_primorial(n,kind=kind)
    s2 = s_factor_cc(n,kind=kind)
    println("$(n) ($(s1)) ($(s2)) $(ndigits(n)) $(CunninghamChains.cunningham_chain(n,kind=kind,check=false))")
end

Base.@ccallable function julia_main()::Cint
  println("1st kind")
  print_primorial(91304653283578934559359)
  print_primorial(2759832934171386593519)
  print_primorial(892390227741617675069)
  print_primorial(810433818265726529159)
  print_primorial(90616211958465842219)

  println("2nd kind")
  print_primorial(2*1540797425367761006138858881-1,kind=2)
  print_primorial(4*658189097608811942204322721-3,kind=2)
  print_primorial(1540797425367761006138858881,kind=2)
  print_primorial(2*658189097608811942204322721-1,kind=2)
  print_primorial(1284167734361435112645318721,kind=2)
  print_primorial(658189097608811942204322721,kind=2)
  print_primorial(2*79910197721667870187016101-1,kind=2)
  print_primorial(182927793839529342111307801,kind=2)
  print_primorial(117302256313688977973793781,kind=2)
  print_primorial(79910197721667870187016101,kind=2)
  print_primorial(42008163485623434922152331,kind=2)
  print_primorial(1302312696655394336638441,kind=2)
  print_primorial(127806074555607670094731,kind=2)
  print_primorial(40244844789379926979141,kind=2)

  return 0
end

if abspath(PROGRAM_FILE) == @__FILE__
  julia_main()
end
