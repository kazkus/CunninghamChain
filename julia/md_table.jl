# $Id$

using JLD
using Printf

function print_hwc()
    C = load("data/hwc.jld")["C"]
    println("|k|Ck|")
    println("|---:|:---|")
    for k in 1:length(C)
        @printf("|`%d`|`%11.10f`|\n", k, C[k])
    end
end

function print_bk()
    B = load("data/bk.jld")["Bk"]
    println("|k|Bk|")
    println("|---:|:---|")
    for k in 1:length(B)
        s = @sprintf("%.10f", B[k])[begin:12]
	@printf("|`%d`|`%s`|\n", k, s)
        
    end
end

function julia_main()
    print_hwc()
    print_bk()
end

if abspath(PROGRAM_FILE) == @__FILE__
    julia_main()
end
