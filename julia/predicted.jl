# $Id$

using Primes
using QuadGK
using Printf
using JLD

function load_Bk()
    dict = load("data/bk.jld")
    return dict["Bk"]
end

B = load_Bk()

function f(x,k)
    y = 1
    for i in 1:k
        y /= log(2^(i-1)*x)
    end
    return y
end

function predicted_integral(N,k)
    g(x) = f(x,k)
    integral, err = quadgk(g, 2, N)
    return Int128(round(B[k]*integral)), B[k]*err
end

function print_predicted_integral(d, k1,k2)
  N = Int128(10)
  N = N^d
  println("predicted integral up to 10^$(d)=$(N)")
  for k in k1:k2
    p, err = predicted_integral(N, k)
    println("k=$(k) : $(p) ($(err))")
  end
end

function julia_main()
    for d in 1:30
        print_predicted_integral(d, 1,20)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    julia_main()
end

