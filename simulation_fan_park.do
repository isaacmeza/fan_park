
********************
version 17.0
********************
/* 
/*******************************************************************************
Simulation exercise to bound the distribution of the treatment effect.
*******************************************************************************/
*/

set obs 2000

*Generate treatment & covariates
gen treat = (runiform()<0.5)
gen z1 = rnormal(10,1)
gen z2 = rnormal(10,10)
gen x1 = rnormal(0,10)
gen x2 = (runiform()<0.75)

*Generate outcome variables
	*Constant treatment effect
gen y1 = x1*(1+x2) + treat*10
	*Heterogeneous treatment effect
gen y2 = x1*(1+x2) + treat*z1
	*HTE with more variance
gen y3 = x1*(1+x2) + treat*z2



*Fan & Park bounds
	*Constant treatment effect
	*HTE with more variance
fan_park y1 treat

	*Heterogeneous treatment effect
fan_park y2 treat
fan_park y2 treat x1 x2
fan_park y2 treat x1 x2 z1

	*HTE with more variance
fan_park y3 treat x1 x2 z1

