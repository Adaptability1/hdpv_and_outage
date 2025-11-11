clear
use D:\data_do\data\data1,clear
forval i = 1/5 {
    append using D:\data_do\data\data`i'.dta   
}
sort n
save D:\data_do\data\data_1104.dta, replace