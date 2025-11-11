*table s1
use D:\data_do\data\data_1104,clear
sum2docx out_sum hdpv hdd cdd wdsp prcp solar_Day  using sum.docx, replace stats(N mean(%9.3f) sd(%9.3f) min max) landscape title("Summary statistics") 

*table s2
use D:\data_do\data\data_1104,clear
ppmlhdfe out_sum hdpv , absorb(c#ym t#city) vce(cluster c)
est store m1
ppmlhdfe out_sum hdpv solar_Day  , absorb(c#ym t#city) vce(cluster c)
est store m2
ppmlhdfe out_sum hdpv hdd cdd wdsp prcp solar_Day  , absorb(c#ym t#city) vce(cluster c)
est store m3
esttab m1 m2 m3  using 2.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.3f) star(* 0.10 ** 0.05 *** 0.01)


***table s3
use D:\data_do\data\data_1104,clear
reghdfe out_sum_day hdd_day cdd_day wind_day solar_day  , absorb(c#ym t#city) vce(cluster c)
est store m1
reghdfe out_sumeve hdpv hddeve cddeve windeve  , absorb(c#ym t#city) vce(cluster c)
est store m2
esttab m* using 3.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.3f) star(* 0.10 ** 0.05 *** 0.01)



***table s4
use D:\data_do\data\data_1104,clear
replace iv=iv/100000000
ivreghdfe out_sum  hdd cdd wdsp prcp solar_Day  (hdpv=iv) , absorb(c#ym t#city) vce(cluster c) first
est store m5
esttab m5 using 4.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.3f) star(* 0.10 ** 0.05 *** 0.01)

***table s5
use D:\data_do\data\data_1104,clear
reghdfe out_sum hdpv  , absorb(c#ym t#city) vce(cluster c)
est store m1
reghdfe out_sum hdpv hdd cdd wdsp prcp solar_Day wind_cap cepv_cap copv_cap , absorb(c#ym t#city) vce(cluster c)
est store m2
esttab m1 m2 using 3.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.3f) star(* 0.10 ** 0.05 *** 0.01)




***table s6
use D:\data_do\data\data_1104,clear
xtset c t
reghdfe out_sum_day hdd_day cdd_day wind_day solar_day   light, absorb(c#ym t#city) vce(cluster c)
est store m1
reghdfe out_sum_day hdd_day cdd_day wind_day solar_day   l.light, absorb(c#ym t#city) vce(cluster c)
est store m2
esttab m1 m2  using 5.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.3f) star(* 0.10 ** 0.05 *** 0.01)


***table s7

use D:\data_do\data\data_1104,clear
xtset c t
drop if ym<=202004
reghdfe out_sum c.hdpv hdd cdd wdsp prcp solar_Day  medium_risk high_risk, absorb(c#ym t#city) vce(cluster c)
est store m1
reghdfe out_sum_day hdd_day cdd_day wind_day solar_day  medium_risk high_risk light, absorb(c#ym t#city) vce(cluster c)
est store m2
reghdfe out_sum_day hdd_day cdd_day wind_day solar_day  medium_risk high_risk l.light, absorb(c#ym t#city) vce(cluster c)
est store m3
esttab m1 m2 m3 using 6.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.3f) star(* 0.10 ** 0.05 *** 0.01)

***table s8
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


***table s9
use D:\data_do\data\data_1104,clear
mkspline hdpv1 30 hdpv2 = hdpv
reghdfe out_sum hdpv1 hdpv2, absorb(c#ym t#city) vce(cluster c)
est store m1
reghdfe out_sum hdpv1 hdpv2 solar_Day  , absorb(c#ym t#city) vce(cluster c)
est store m2
reghdfe out_sum hdpv1 hdpv2 hdd cdd wdsp prcp solar_Day  , absorb(c#ym t#city) vce(cluster c)
est store m3
esttab m1 m2 m3 using 1.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.3f) star(* 0.10 ** 0.05 *** 0.01)

***table s10
use D:\data_do\data\data_1104,clear
mkspline hdpv1 30 hdpv2 = hdpv
reghdfe out_sum c.hdpv1##c.invest c.hdpv2   hdd cdd wdsp prcp solar_Day  , absorb(c#ym t#city) vce(cluster c)
est store m1
reghdfe out_sum c.hdpv1 c.hdpv2##c.invest  hdd cdd wdsp prcp solar_Day  , absorb(c#ym t#city) vce(cluster c)
est store m2
reghdfe out_sum c.hdpv1##c.invest c.hdpv2##c.invest  hdd cdd wdsp prcp solar_Day  , absorb(c#ym t#city) vce(cluster c)
est store m3
esttab m1 m2 m3 using 2.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.3f) star(* 0.10 ** 0.05 *** 0.01)




***figure s1
use D:\data_do\data\data_1104,clear
drop if hdpv==0
centile hdpv, centile(25 50 75)
local k25 = r(c_1)
local k75 = r(c_2)
local k90 = r(c_3)
mkspline dose = hdpv, cubic knots(`k25' `k75' `k90' )
*mkspline dose = hdpv, cubic knots(25 75 90)
*centile 负荷_rounded, centile(25 75 90)
reghdfe out_sum dose1 dose2  hdd cdd wdsp prcp solar_Day , absorb(c#ym t#city) vce(cluster c)
keep if e(sample)
gen 负荷_rounded = round(hdpv, 2)
levelsof 负荷_rounded if inrange(负荷_rounded, 0, 60), local(levels)
xblc dose1-dose2, covname(负荷_rounded) at (`levels') reference(0) gen(a1 a2 a3 a4) level(95)
keep a1 a2 a3 a4
drop if a1==.
// 正确计算边际效应：相邻点的斜率
sort a1
gen marginal_effect = (a2 - a2[_n-1]) / (a1 - a1[_n-1]) if _n > 1
gen marginal_lb = (a3 - a3[_n-1]) / (a1 - a1[_n-1]) if _n > 1
gen marginal_ub = (a4 - a4[_n-1]) / (a1 - a1[_n-1]) if _n > 1
egen min=rowmin(marginal_lb  marginal_ub)
egen max=rowmax(marginal_lb  marginal_ub)
replace marginal_lb=min
replace marginal_ub=max 
drop max min
// 画边际效应图
graph twoway (rarea marginal_ub marginal_lb a1 if _n > 1 ,color("240 230 150 %30" )) ///
             (line marginal_effect a1 if _n > 1, lcolor("140 125 180")), ///
    title("(a)Marginal effect(knots=25% 50% 75%)" ,size(5) pos(11)) ///
    ytitle("d(Outage hours)/d(HDPV)",size(5)) ///
    xtitle("HDPV",size(5)) ///
	yline(0, lcolor(gs4) lpattern(dash)) legend(off) ///	
	xlabel( 0 "0"  30 "30" 60 "60" ,labsize(*1.3) ) ///
	ylabel( -0.2 "-0.2" -0.1 "-0.1"  0 "0" 0.1 "0.1"  0.2 "0.2" 0.3 "0.3"  0.4 "0.4" ,labsize(*1.3))
graph export "D:\data_do\data\2.png", as(png) replace width(2000) height(1500)	
graph save "Graph" D:\data_do\data\f1.gph,replace




use D:\data_do\data\data_1104,clear
centile hdpv, centile(50 70 90)
local k25 = r(c_1)
local k75 = r(c_2)
local k90 = r(c_3)
mkspline dose = hdpv, cubic knots(`k25' `k75' `k90' )
*mkspline dose = hdpv, cubic knots(25 75 90)
*centile 负荷_rounded, centile(25 75 90)
reghdfe out_sum dose1 dose2  hdd cdd wdsp prcp solar_Day , absorb(c#ym t#city) vce(cluster c)
keep if e(sample)
gen 负荷_rounded = round(hdpv, 2)
levelsof 负荷_rounded if inrange(负荷_rounded, 0, 60), local(levels)
xblc dose1-dose2, covname(负荷_rounded) at (`levels') reference(0) gen(a1 a2 a3 a4) level(95)
keep a1 a2 a3 a4
drop if a1==.
// 正确计算边际效应：相邻点的斜率
sort a1
gen marginal_effect = (a2 - a2[_n-1]) / (a1 - a1[_n-1]) if _n > 1
gen marginal_lb = (a3 - a3[_n-1]) / (a1 - a1[_n-1]) if _n > 1
gen marginal_ub = (a4 - a4[_n-1]) / (a1 - a1[_n-1]) if _n > 1
egen min=rowmin(marginal_lb  marginal_ub)
egen max=rowmax(marginal_lb  marginal_ub)
replace marginal_lb=min
replace marginal_ub=max 
drop max min
// 画边际效应图
graph twoway (rarea marginal_ub marginal_lb a1 if _n > 1 ,color("240 230 150 %30" )) ///
             (line marginal_effect a1 if _n > 1, lcolor("140 125 180")), ///
    title("(b)Marginal effect(knots=50% 70% 90%)" ,size(5) pos(11)) ///
    ytitle("d(Outage hours)/d(HDPV)",size(5)) ///
    xtitle("HDPV",size(5)) ///
	yline(0, lcolor(gs4) lpattern(dash)) legend(off) ///	
	xlabel( 0 "0"  30 "30" 60 "60"  ,labsize(*1.3)) ///
	ylabel( -0.2 "-0.2" -0.1 "-0.1"  0 "0" 0.1 "0.1"  0.2 "0.2" 0.3 "0.3"  0.4 "0.4" ,labsize(*1.3))
graph export "D:\data_do\data\1.png", as(png) replace width(2000) height(1500)	
graph save "Graph" D:\data_do\data\f2.gph,replace



use D:\data_do\data\data_1104,clear
centile hdpv, centile(50 90 97)
local k25 = r(c_1)
local k75 = r(c_2)
local k90 = r(c_3)
mkspline dose = hdpv, cubic knots(`k25' `k75' `k90' )
*mkspline dose = hdpv, cubic knots(25 75 90)
*centile 负荷_rounded, centile(25 75 90)
reghdfe out_sum dose1 dose2  hdd cdd wdsp prcp solar_Day , absorb(c#ym t#city) vce(cluster c)
keep if e(sample)
gen 负荷_rounded = round(hdpv, 2)
levelsof 负荷_rounded if inrange(负荷_rounded, 0, 60), local(levels)
xblc dose1-dose2, covname(负荷_rounded) at (`levels') reference(0) gen(a1 a2 a3 a4) level(95)
keep a1 a2 a3 a4
drop if a1==.
// 正确计算边际效应：相邻点的斜率
sort a1
gen marginal_effect = (a2 - a2[_n-1]) / (a1 - a1[_n-1]) if _n > 1
gen marginal_lb = (a3 - a3[_n-1]) / (a1 - a1[_n-1]) if _n > 1
gen marginal_ub = (a4 - a4[_n-1]) / (a1 - a1[_n-1]) if _n > 1
egen min=rowmin(marginal_lb  marginal_ub)
egen max=rowmax(marginal_lb  marginal_ub)
replace marginal_lb=min
replace marginal_ub=max 
drop max min
// 画边际效应图
graph twoway (rarea marginal_ub marginal_lb a1 if _n > 1 ,color("240 230 150 %30" )) ///
             (line marginal_effect a1 if _n > 1, lcolor("140 125 180")), ///
    title("(c)Marginal effect(knots=50% 90% 97%)" ,size(5) pos(11)) ///
    ytitle("d(Outage hours)/d(HDPV)",size(5)) ///
    xtitle("HDPV",size(5)) ///
	yline(0, lcolor(gs4) lpattern(dash)) legend(off) ///	
	xlabel( 0 "0"  30 "30" 60 "60" ,labsize(*1.3) ) ///
	ylabel( -0.2 "-0.2" -0.1 "-0.1"  0 "0" 0.1 "0.1"  0.2 "0.2" 0.3 "0.3"  0.4 "0.4" ,labsize(*1.3))
graph export "D:\data_do\data\3.png", as(png) replace width(2000) height(1500)	
graph save "Graph" D:\data_do\data\f3.gph,replace

use D:\data_do\data\data_1104,clear
centile hdpv, centile(80 90 97)
local k25 = r(c_1)
local k75 = r(c_2)
local k90 = r(c_3)
mkspline dose = hdpv, cubic knots(`k25' `k75' `k90' )
*mkspline dose = hdpv, cubic knots(25 75 90)
*centile 负荷_rounded, centile(25 75 90)
reghdfe out_sum dose1 dose2  hdd cdd wdsp prcp solar_Day , absorb(c#ym t#city) vce(cluster c)
keep if e(sample)
gen 负荷_rounded = round(hdpv, 2)
levelsof 负荷_rounded if inrange(负荷_rounded, 0, 60), local(levels)
xblc dose1-dose2, covname(负荷_rounded) at (`levels') reference(0) gen(a1 a2 a3 a4) level(95)
keep a1 a2 a3 a4
drop if a1==.
// 正确计算边际效应：相邻点的斜率
sort a1
gen marginal_effect = (a2 - a2[_n-1]) / (a1 - a1[_n-1]) if _n > 1
gen marginal_lb = (a3 - a3[_n-1]) / (a1 - a1[_n-1]) if _n > 1
gen marginal_ub = (a4 - a4[_n-1]) / (a1 - a1[_n-1]) if _n > 1
egen min=rowmin(marginal_lb  marginal_ub)
egen max=rowmax(marginal_lb  marginal_ub)
replace marginal_lb=min
replace marginal_ub=max 
drop max min
// 画边际效应图
graph twoway (rarea marginal_ub marginal_lb a1 if _n > 1 ,color("240 230 150 %30" )) ///
             (line marginal_effect a1 if _n > 1, lcolor("140 125 180")), ///
    title("(d)Marginal effect(knots=80% 90% 97%)" ,size(5) pos(11)) ///
    ytitle("d(Outage hours)/d(HDPV)",size(5)) ///
    xtitle("HDPV",size(5)) ///
	yline(0, lcolor(gs4) lpattern(dash)) legend(off) ///	
	xlabel( 0 "0"  30 "30" 60 "60"  ,labsize(*1.3) ) ///
	ylabel( -0.2 "-0.2" -0.1 "-0.1"  0 "0" 0.1 "0.1"  0.2 "0.2" 0.3 "0.3"  0.4 "0.4",labsize(*1.3))
graph export "D:\data_do\data\4.png", as(png) replace width(2000) height(1500)	
graph save "Graph" D:\data_do\data\f4.gph,replace

cd D:\data_do\data\
graph combine f1.gph f2.gph f3.gph  f4.gph, row(2)  iscale(0.4)
graph export "D:\data_do\data\f1.png", as(png) replace width(2000) height(1500)
graph export "D:\data_do\data\Graph.tif", as(tif) name("Graph") replace


****figure s2
cd D:\data_do\data\
use D:\data_do\data\data_1104,clear
est clear
mkspline hdpv1 30 hdpv2 = hdpv
reghdfe out_sum hdpv1 hdpv2 hdd cdd wdsp prcp solar_Day  , absorb(c#ym t#city) vce(cluster c)
est store m0
parmest , saving(m.dta, replace) idstr(m0) idnum(0)
forvalues i=1/11{
reghdfe out_sum hdpv1 hdpv2 hdd cdd wdsp prcp solar_Day   if  p==`i', absorb(c#ym t#city) vce(cluster c)
est store m`i'
parmest , saving(m`i'.dta, replace) idstr(m`i') idnum(`i')
}
esttab m0 m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11  using 12.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.3f) star(* 0.10 ** 0.05 *** 0.01)
*****
est clear
reghdfe out_sum hdpv hdd cdd wdsp prcp solar_Day  , absorb(c#ym t#city) vce(cluster c)
est store m0
parmest , saving(h.dta, replace) idstr(m0) idnum(0)
forvalues i=1/11{
reghdfe out_sum hdpv hdd cdd wdsp prcp solar_Day   if  p==`i', absorb(c#ym t#city) vce(cluster c)
est store m`i'
parmest , saving(h`i'.dta, replace) idstr(m`i') idnum(`i')
}
esttab m0  m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11  using 13.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.3f) star(* 0.10 ** 0.05 *** 0.01)

use h,clear
append using m
gen n=1 if parm=="hdpv1"
replace n=0 if parm=="hdpv2"
replace n=2 if parm=="hdpv"
drop if n==.
so n
gen id = n
gen id_tight=0.4 * id 
replace n=id_tight
twoway ///
    (bar estimate id_tight if id==0, horizontal color("230 159 0") barw(.2)) ///
    (bar estimate id_tight if id==1, horizontal color("185 193 106") barw(.2)) ///
    (bar estimate id_tight if id==2, horizontal color("140 125 180") barw(.2)) ///
    (rcap min95 max95 n if id==0, horizontal color("230 159 0") lw(medium)) ///
    (rcap min95 max95 n if id==1, horizontal color("185 193 106") lw(medium)) ///
    (rcap min95 max95 n if id==2, horizontal color("140 125 180") lw(medium)), ///
	ylabel(0.8 "All" 0.4 "0-30" 0 ">30", angle(0) labsize(*1.2)) ///
    title("(a) All", size(5) margin(0 0 0 0) pos(12)) ///
    xline(0, lcolor(gs4)) ///
    legend(off) ///
    graphregion(margin(0 0 0 5) color(white) lstyle(none)) ///
    plotregion(margin(0 10 0 0) lstyle(none )) ///
    xscale(noline) yscale(noline) ///
    xlabel( -0.06 "-0.06"  0 "0" 0.06 "0.06" 0.12 "0.12",labsize(*1.2) ) 
	
	*graphregion(lcolor(gs10) lwidth(vthin)) 
graph save "Graph" D:\data_do\data\0.gph,replace

use h1,clear
append using m1
gen n=1 if parm=="hdpv1"
replace n=0 if parm=="hdpv2"
replace n=2 if parm=="hdpv"
drop if n==.
so n
gen id = n
gen id_tight=0.4 * id 
replace n=id_tight
twoway ///
    (bar estimate id_tight if id==0, horizontal color("230 159 0") barw(.2)) ///
    (bar estimate id_tight if id==1, horizontal color("185 193 106") barw(.2)) ///
    (bar estimate id_tight if id==2, horizontal color("140 125 180") barw(.2)) ///
    (rcap min95 max95 n if id==0, horizontal color("230 159 0") lw(medium)) ///
    (rcap min95 max95 n if id==1, horizontal color("185 193 106") lw(medium)) ///
    (rcap min95 max95 n if id==2, horizontal color("140 125 180") lw(medium)), ///
	ylabel(0.8 "All" 0.4 "0-30" 0 ">30", angle(0) labsize(*1.2)) ///
    title("(b) Shandong", size(5) margin(0 0 0 0) pos(12)) ///
    xline(0, lcolor(gs4)) ///
    legend(off) ///
    graphregion(margin(0 0 0 5) color(white) lstyle(none)) ///
    plotregion(margin(0 10 0 0) lstyle(none )) ///
    xscale(noline) yscale(noline) ///
    xlabel( -0.06 "-0.06"  0 "0" 0.06 "0.06" 0.12 "0.12",labsize(*1.2) ) 
	*graphregion(lcolor(gs10) lwidth(vthin)) 
graph save "Graph" D:\data_do\data\1.gph,replace


use h2,clear
append using m2
gen n=1 if parm=="hdpv1"
replace n=0 if parm=="hdpv2"
replace n=2 if parm=="hdpv"
drop if n==.
so n
gen id = n
gen id_tight=0.4 * id 
replace n=id_tight
twoway ///
    (bar estimate id_tight if id==0, horizontal color("230 159 0") barw(.2)) ///
    (bar estimate id_tight if id==1, horizontal color("185 193 106") barw(.2)) ///
    (bar estimate id_tight if id==2, horizontal color("140 125 180") barw(.2)) ///
    (rcap min95 max95 n if id==0, horizontal color("230 159 0") lw(medium)) ///
    (rcap min95 max95 n if id==1, horizontal color("185 193 106") lw(medium)) ///
    (rcap min95 max95 n if id==2, horizontal color("140 125 180") lw(medium)), ///
	ylabel(0.8 "All" 0.4 "0-30" 0 ">30", angle(0) labsize(*1.2)) ///
    title("(c) Shanxi", size(5) margin(0 0 0 0) pos(12)) ///
    xline(0, lcolor(gs4)) ///
    legend(off) ///
    graphregion(margin(0 0 0 5) color(white) lstyle(none)) ///
    plotregion(margin(0 10 0 0) lstyle(none )) ///
    xscale(noline) yscale(noline) ///
    xlabel( -0.15 "-0.15"  0 "0" 0.15 "0.15" 0.3 "0.3" ,labsize(*1.2) ) 
	*graphregion(lcolor(gs10) lwidth(vthin)) 
graph save "Graph" D:\data_do\data\2.gph,replace

use h3,clear
append using m3
gen n=1 if parm=="hdpv1"
replace n=0 if parm=="hdpv2"
replace n=2 if parm=="hdpv"
drop if n==.
so n
gen id = n
gen id_tight=0.4 * id 
replace n=id_tight
twoway ///
    (bar estimate id_tight if id==0, horizontal color("230 159 0") barw(.2)) ///
    (bar estimate id_tight if id==1, horizontal color("185 193 106") barw(.2)) ///
    (bar estimate id_tight if id==2, horizontal color("140 125 180") barw(.2)) ///
    (rcap min95 max95 n if id==0, horizontal color("230 159 0") lw(medium)) ///
    (rcap min95 max95 n if id==1, horizontal color("185 193 106") lw(medium)) ///
    (rcap min95 max95 n if id==2, horizontal color("140 125 180") lw(medium)), ///
	ylabel(0.8 "All" 0.4 "0-30" 0 ">30", angle(0) labsize(*1.2)) ///
    title("(g) Jiangsu", size(5) margin(0 0 0 0) pos(12)) ///
    xline(0, lcolor(gs4)) ///
    legend(off) ///
    graphregion(margin(0 0 0 5) color(white) lstyle(none)) ///
    plotregion(margin(0 10 0 0) lstyle(none )) ///
    xscale(noline) yscale(noline) ///
    xlabel( -0.8 "-0.8"  0 "0" 0.8 "0.8" 1.6 "1.6",labsize(*1.2) ) 
	*graphregion(lcolor(gs10) lwidth(vthin)) 
graph save "Graph" D:\data_do\data\6.gph,replace



use h4,clear
append using m4
gen n=1 if parm=="hdpv1"
replace n=0 if parm=="hdpv2"
replace n=2 if parm=="hdpv"
drop if n==.
so n
gen id = n
gen id_tight=0.4 * id 
replace n=id_tight
twoway ///
    (bar estimate id_tight if id==0, horizontal color("230 159 0") barw(.2)) ///
    (bar estimate id_tight if id==1, horizontal color("185 193 106") barw(.2)) ///
    (bar estimate id_tight if id==2, horizontal color("140 125 180") barw(.2)) ///
    (rcap min95 max95 n if id==0, horizontal color("230 159 0") lw(medium)) ///
    (rcap min95 max95 n if id==1, horizontal color("185 193 106") lw(medium)) ///
    (rcap min95 max95 n if id==2, horizontal color("140 125 180") lw(medium)), ///
	ylabel(0.8 "All" 0.4 "0-30" 0 ">30", angle(0) labsize(*1.2)) ///
    title("(e) Hebei", size(5) margin(0 0 0 0) pos(12)) ///
    xline(0, lcolor(gs4)) ///
    legend(off) ///
    graphregion(margin(0 0 0 5) color(white) lstyle(none)) ///
    plotregion(margin(0 10 0 0) lstyle(none )) ///
    xscale(noline) yscale(noline) ///
    xlabel( -0.16 "-0.16"  0 "0" 0.16 "0.16" 0.32 "0.32",labsize(*1.2) ) 
	*graphregion(lcolor(gs10) lwidth(vthin)) 
graph save "Graph" D:\data_do\data\4.gph,replace

use h5,clear
append using m5
gen n=1 if parm=="hdpv1"
replace n=0 if parm=="hdpv2"
replace n=2 if parm=="hdpv"
drop if n==.
so n
gen id = n
gen id_tight=0.4 * id 
replace n=id_tight
twoway ///
    (bar estimate id_tight if id==0, horizontal color("230 159 0") barw(.2)) ///
    (bar estimate id_tight if id==1, horizontal color("185 193 106") barw(.2)) ///
    (bar estimate id_tight if id==2, horizontal color("140 125 180") barw(.2)) ///
    (rcap min95 max95 n if id==0, horizontal color("230 159 0") lw(medium)) ///
    (rcap min95 max95 n if id==1, horizontal color("185 193 106") lw(medium)) ///
    (rcap min95 max95 n if id==2, horizontal color("140 125 180") lw(medium)), ///
	ylabel(0.8 "All" 0.4 "0-30" 0 ">30", angle(0) labsize(*1.2)) ///
    title("(i) Hubei", size(5) margin(0 0 0 0) pos(12)) ///
    xline(0, lcolor(gs4)) ///
    legend(off) ///
    graphregion(margin(0 0 0 5) color(white) lstyle(none)) ///
    plotregion(margin(0 10 0 0) lstyle(none )) ///
    xscale(noline) yscale(noline) ///
    xlabel( -2 "-2"  0 "0" 2 "2" 4 "4" ,labsize(*1.2) ) 
	*graphregion(lcolor(gs10) lwidth(vthin)) 
graph save "Graph" D:\data_do\data\8.gph,replace



use h6,clear
append using m6
gen n=1 if parm=="hdpv1"
replace n=0 if parm=="hdpv2"
replace n=2 if parm=="hdpv"
drop if n==.
so n
gen id = n
gen id_tight=0.4 * id 
replace n=id_tight
twoway ///
    (bar estimate id_tight if id==0, horizontal color("230 159 0") barw(.2)) ///
    (bar estimate id_tight if id==1, horizontal color("185 193 106") barw(.2)) ///
    (bar estimate id_tight if id==2, horizontal color("140 125 180") barw(.2)) ///
    (rcap min95 max95 n if id==0, horizontal color("230 159 0") lw(medium)) ///
    (rcap min95 max95 n if id==1, horizontal color("185 193 106") lw(medium)) ///
    (rcap min95 max95 n if id==2, horizontal color("140 125 180") lw(medium)), ///
	ylabel(0.8 "All" 0.4 "0-30" 0 ">30", angle(0) labsize(*1.2)) ///
    title("(k) Hunan", size(5) margin(0 0 0 0) pos(12)) ///
    xline(0, lcolor(gs4)) ///
    legend(off) ///
    graphregion(margin(0 0 0 5) color(white) lstyle(none)) ///
    plotregion(margin(0 10 0 0) lstyle(none )) ///
    xscale(noline) yscale(noline) ///
    xlabel( -2.5 "-2.5"  0 "0" 2.5 "2.5" 5 "5" ,labsize(*1.2) ) 
	*graphregion(lcolor(gs10) lwidth(vthin)) 
graph save "Graph" D:\data_do\data\10.gph,replace




use h7,clear
append using m7
gen n=1 if parm=="hdpv1"
replace n=0 if parm=="hdpv2"
replace n=2 if parm=="hdpv"
drop if n==.
so n
gen id = n
gen id_tight=0.4 * id 
replace n=id_tight
twoway ///
    (bar estimate id_tight if id==0, horizontal color("230 159 0") barw(.2)) ///
    (bar estimate id_tight if id==1, horizontal color("185 193 106") barw(.2)) ///
    (bar estimate id_tight if id==2, horizontal color("140 125 180") barw(.2)) ///
    (rcap min95 max95 n if id==0, horizontal color("230 159 0") lw(medium)) ///
    (rcap min95 max95 n if id==1, horizontal color("185 193 106") lw(medium)) ///
    (rcap min95 max95 n if id==2, horizontal color("140 125 180") lw(medium)), ///
	ylabel(0.8 "All" 0.4 "0-30" 0 ">30", angle(0) labsize(*1.2)) ///
    title("(f) Fujian", size(5) margin(0 0 0 0) pos(12)) ///
    xline(0, lcolor(gs4)) ///
    legend(off) ///
    graphregion(margin(0 0 0 5) color(white) lstyle(none)) ///
    plotregion(margin(0 10 0 0) lstyle(none )) ///
    xscale(noline) yscale(noline) ///
    xlabel( -0.5 "-0.5"  0 "0" 0.5 "0.5" 1 "1" ,labsize(*1.2) ) 
	*graphregion(lcolor(gs10) lwidth(vthin)) 
graph save "Graph" D:\data_do\data\5.gph,replace



use h8,clear
append using m8
gen n=1 if parm=="hdpv1"
replace n=0 if parm=="hdpv2"
replace n=2 if parm=="hdpv"
drop if n==.
so n
gen id = n
gen id_tight=0.4 * id 
replace n=id_tight
twoway ///
    (bar estimate id_tight if id==0, horizontal color("230 159 0") barw(.2)) ///
    (bar estimate id_tight if id==1, horizontal color("185 193 106") barw(.2)) ///
    (bar estimate id_tight if id==2, horizontal color("140 125 180") barw(.2)) ///
    (rcap min95 max95 n if id==0, horizontal color("230 159 0") lw(medium)) ///
    (rcap min95 max95 n if id==1, horizontal color("185 193 106") lw(medium)) ///
    (rcap min95 max95 n if id==2, horizontal color("140 125 180") lw(medium)), ///
	ylabel(0.8 "All" 0.4 "0-30" 0 ">30", angle(0) labsize(*1.2)) ///
    title("(d) Liaoning", size(5) margin(0 0 0 0) pos(12)) ///
    xline(0, lcolor(gs4)) ///
    legend(off) ///
    graphregion(margin(0 0 0 5) color(white) lstyle(none)) ///
    plotregion(margin(0 10 0 0) lstyle(none )) ///
    xscale(noline) yscale(noline) ///
    xlabel( -0.1 "-0.1"  0 "0" 0.1 "0.1" 0.2 "0.2" ,labsize(*1.2) ) 
	*graphregion(lcolor(gs10) lwidth(vthin)) 
graph save "Graph" D:\data_do\data\3.gph,replace

use h9,clear
append using m9
gen n=1 if parm=="hdpv1"
replace n=0 if parm=="hdpv2"
replace n=2 if parm=="hdpv"
drop if n==.
so n
gen id = n
gen id_tight=0.4 * id 
replace n=id_tight
twoway ///
    (bar estimate id_tight if id==0, horizontal color("230 159 0") barw(.2)) ///
    (bar estimate id_tight if id==1, horizontal color("185 193 106") barw(.2)) ///
    (bar estimate id_tight if id==2, horizontal color("140 125 180") barw(.2)) ///
    (rcap min95 max95 n if id==0, horizontal color("230 159 0") lw(medium)) ///
    (rcap min95 max95 n if id==1, horizontal color("185 193 106") lw(medium)) ///
    (rcap min95 max95 n if id==2, horizontal color("140 125 180") lw(medium)), ///
	ylabel(0.8 "All" 0.4 "0-30" 0 ">30", angle(0) labsize(*1.2)) ///
    title("(j) Chongqing", size(5) margin(0 0 0 0) pos(12)) ///
    xline(0, lcolor(gs4)) ///
    legend(off) ///
    graphregion(margin(0 0 0 5) color(white) lstyle(none)) ///
    plotregion(margin(0 10 0 0) lstyle(none )) ///
    xscale(noline) yscale(noline) ///
    xlabel( -40 "-40"  0 "0" 40 "40" 80 "80" ,labsize(*1.2) ) 
	*graphregion(lcolor(gs10) lwidth(vthin)) 
graph save "Graph" D:\data_do\data\9.gph,replace

use h10,clear
append using m10
gen n=1 if parm=="hdpv1"
replace n=0 if parm=="hdpv2"
replace n=2 if parm=="hdpv"
drop if n==.
so n
gen id = n
gen id_tight=0.4 * id 
replace n=id_tight
twoway ///
    (bar estimate id_tight if id==0, horizontal color("230 159 0") barw(.2)) ///
    (bar estimate id_tight if id==1, horizontal color("185 193 106") barw(.2)) ///
    (bar estimate id_tight if id==2, horizontal color("140 125 180") barw(.2)) ///
    (rcap min95 max95 n if id==0, horizontal color("230 159 0") lw(medium)) ///
    (rcap min95 max95 n if id==1, horizontal color("185 193 106") lw(medium)) ///
    (rcap min95 max95 n if id==2, horizontal color("140 125 180") lw(medium)), ///
	ylabel(0.8 "All" 0.4 "0-30" 0 ">30", angle(0) labsize(*1.2)) ///
    title("(h) Shannxi", size(5) margin(0 0 0 0) pos(12)) ///
    xline(0, lcolor(gs4)) ///
    legend(off) ///
    graphregion(margin(0 0 0 5) color(white) lstyle(none)) ///
    plotregion(margin(0 10 0 0) lstyle(none )) ///
    xscale(noline) yscale(noline) ///
    xlabel( -1.5 "-1.5"  0 "0" 1.5 "1.5" 3 "3" ,labsize(*1.2) ) 
	*graphregion(lcolor(gs10) lwidth(vthin)) 
graph save "Graph" D:\data_do\data\7.gph,replace



use h11,clear
append using m11
gen n=1 if parm=="hdpv1"
replace n=0 if parm=="hdpv2"
replace n=2 if parm=="hdpv"
drop if n==.
so n
gen id = n
gen id_tight=0.4 * id 
replace n=id_tight
local lcolor gs10          // 淡灰色，想要黑色用 black
local lwidth vthin         // 细线，也可 thin / medium
twoway ///
    (bar estimate id_tight if id==0, horizontal color("230 159 0") barw(.2)) ///
    (bar estimate id_tight if id==1, horizontal color("185 193 106") barw(.2)) ///
    (bar estimate id_tight if id==2, horizontal color("140 125 180") barw(.2)) ///
    (rcap min95 max95 n if id==0, horizontal color("230 159 0") lw(medium)) ///
    (rcap min95 max95 n if id==1, horizontal color("185 193 106") lw(medium)) ///
    (rcap min95 max95 n if id==2, horizontal color("140 125 180") lw(medium)), ///
	ylabel(0.8 "All" 0.4 "0-30" 0 ">30", angle(0) labsize(*1.2)) ///
    title("(l) Heilongjiang", size(5) margin(0 0 0 0) pos(12)) ///
    xline(0, lcolor(gs4)) ///
    legend(off) ///
    graphregion(margin(0 0 0 5) color(white) lstyle(none)) ///
    plotregion(margin(0 10 0 0) lstyle(none )) ///
    xscale(noline) yscale(noline) ///
    xlabel( -3.5 "-3.5"  0 "0" 3.5 "3.5" 7 "7" ,labsize(*1.2) )
	*graphregion(lcolor(gs10) lwidth(vthin)) 
graph save "Graph" D:\data_do\data\11.gph,replace

cd D:\data_do\data\
graph combine 0.gph 1.gph 2.gph 3.gph 4.gph 5.gph 6.gph 7.gph 8.gph  9.gph 10.gph 11.gph, row(3)  iscale(0.52)
graph export "D:\data_do\data\  1.png", as(png) replace width(2000) height(1500)
graph export "D:\data_do\data\Graph.tif", as(tif) name("Graph") replace