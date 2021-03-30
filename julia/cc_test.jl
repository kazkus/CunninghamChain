# $Id$

include("cc.jl")

function print_cc(p)
    # k = cunningham_chain(p, kind=1, check=false)
        # ERROR: LoadError: UndefVarError: cunningham_chain not defined
    k = CunninghamChains.cunningham_chain(p, kind=1, check=false)
    d = ndigits(p) # ndigits is OK !?
    println("$(p) $(d) $(k)")
end

Base.@ccallable function julia_main()::Cint
  print_cc(91304653283578934559359)
  print_cc(2759832934171386593519)
  print_cc(892390227741617675069)
  print_cc(810433818265726529159)
  print_cc(90616211958465842219)
  return 0
end

if abspath(PROGRAM_FILE) == @__FILE__
  julia_main()
end
