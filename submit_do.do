cd D:\data_do\data\

**figure 1
use D:\data_do\data\data_1104,clear
bys c: egen sumout=sum(out_sum)
keep if t==698
drop z
egen z=tag(c)
drop if z==0
keep c hdpv sumout
export delimited using "D:\data_do\data\figure1.csv", replace
*table 1
use D:\data_do\data\data_1104,clear
reghdfe out_sum hdpv , absorb(c#ym t#city) vce(cluster c)
est store m1
reghdfe out_sum hdpv solar_Day  , absorb(c#ym t#city) vce(cluster c)
est store m2
reghdfe out_sum hdpv hdd cdd wdsp prcp solar_Day  , absorb(c#ym t#city) vce(cluster c)
est store m3
esttab m1 m2 m3 using 1.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.3f) star(* 0.10 ** 0.05 *** 0.01)
***figure 2
use D:\data_do\data\data_1104,clear
est clear
forvalues i=0/21{
reghdfe out_sum`i' hdpv hdd`i' cdd`i' wind`i' solar`i'  , absorb(c#ym t#city) vce(cluster c)
est store m`i'
}
forvalues i=22/23{
reghdfe out_sum`i' hdpv hdd`i' cdd`i' wind`i'   , absorb(c#ym t#city) vce(cluster c)
est store m`i'
}
esttab m* using q1.csv,scalars(r2 r2_w r2_o r2_b) pr2  p  replace nogap  b(%9.5f) star(* 0.10 ** 0.05 *** 0.01)
coefplot (m0, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) ))(m1, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m2,keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m3, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m4,keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m5, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m6,keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m7, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m8,keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m9, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m10,keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) ))(m11, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m12,keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m13, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m14,keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m15, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m16,keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m17, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m18,keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m19, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m20,keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) ))  (m21, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m22,keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )) (m23, keep(hdpv) mc("140 125 180") lc("230 159 0")  ms(circle) ciopt(recast(ci) lcolor("230 159 0") lw(0.2) )), vertical nolabel graphregion(color(white)) ylabel(,labsize(*1))   mcolor(black) legend(off) graphregion(fcolor(white)) ytitle("Coefficient",size(4)) addplot(line @b @at, lcolor("140 125 180") lpattern(solid)) xlabel(0.54 "0" 0.58 "1" 0.62 "2" 0.66 "3" 0.7 "4" 0.74 "5" 0.78 "6" 0.82 "7" 0.86 "8" 0.9 "9" 0.94 "10" 0.98 "11" 1.02 "12" 1.06 "13" 1.1 "14" 1.14 "15" 1.18 "16" 1.22 "17" 1.26 "18" 1.3 "19" 1.34 "20" 1.38 "21" 1.42 "22" 1.46 "23", nogrid labsize(*0.8))  yline(0,lc(gray) lp(solid))  xtitle("Hour") title("Hourly impacts of HDPV on power outage hours", pos(11) size(4)) 
graph export "D:\data_do\data\2.png", as(png) replace width(2000) height(1500)
*******************figure 3
use D:\data_do\data\figure_3,clear
export delimited using "D:\data_do\data\figure3.csv", replace

















