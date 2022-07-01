{smcl}
{* *!version 1.0.1  2022-04-30}{...}
{viewerjumpto "Syntax" "fan_park##syntax"}{...}
{viewerjumpto "Description" "fan_park##description"}{...}
{viewerjumpto "Options" "fan_park##options"}{...}
{viewerjumpto "Examples" "fan_park##examples"}{...}
{viewerjumpto "Stored results" "fan_park##stored_results"}{...}
{viewerjumpto "References" "fan_park##references"}{...}
{viewerjumpto "Authors" "fan_park##authors"}{...}

{title:Title}

{p 4 8}{cmd:fan_park} {hline 2} Sharp Bounds on the Distribution of Treatment Effects.{p_end}

{marker syntax}{...}
{title:Syntax}

{p 4 8}{cmd:fan_park} {it:depvar} {it:treatvar} [{it:indepvars}] {ifin} 
[{cmd:,} 
{cmd:delta_partition(}{it:#}{cmd:)} 
{cmd:delta_values(}{it:numlist}{cmd:)} 
{cmd:cov_partition(}{it:#}{cmd:)} 
{cmd:level(}{it:#}{cmd:)} 
{cmd:nograph} 
{cmd:seed(}{it:#}{cmd:)} 
{cmd:qbounds} 
{cmd:num_quantiles(}{it:#}{cmd:)}
]{p_end}

{synoptset 28 tabbed}{...}

{marker description}{...}
{title:Description}

{p 4 8}{cmd:fan_park} implements nonparametric estimators, and inference, of sharp bounds on the distribution of treatment effects of a binary treatment developed in {browse "https://doi.org/10.1017/S0266466609990168":Fan, and Park (2009)}.

{p 8 8} Let Delta = Y_1-Y_0 denote the treatment effect or outcome gain, and F_{Delta}(.) its distribution function. Given the marginals F_1 and F_0 we can compute sharp bounds on the distribution of Delta for each x in the support of F_{Delta}, that is : F_L(x)<=F_{Delta}(x)<=F_U(x). Alternatively, when the option qbounds is given, {cmd:fan_park} computes bounds for the quantile function :  
F_U^{-1}(q)<=F_{Delta}^{-1}(q)<=F_L^{-1}(q).{p_end}

{marker arguments}{...}
{title:Arguments}
{dlgtab:Arguments}

{p 8 8} {it:depvar}, this is the outcome of interest. Results are more meaningful when outcome is a continuous variable, but it also works for binary variables.{p_end}

{p 8 8} {it:treatvar}, binary (0-1) treatment variable. {p_end}

{p 8 8} [{it:indepvars}], varlist of independent variables. Factor or time series variables not allowed.{p_end}


{marker options}{...}
{title:Options}

{dlgtab:Options}

{p 4 8}{cmd:delta_partition(}{it:#}{cmd:)} specifies the number of points (x) in an equally spaced partition of the support of the treatment effect (Y_1-Y_0).
Default is {cmd:delta_partition(100)}.{p_end}

{p 4 8}{cmd:delta_values(}{it:numlist}{cmd:)} specifies the points (x) where the bounds are computed. If this option is specified, then it supercedes the option {cmd:delta_partition(}{it:#}{cmd:)}.{p_end}

{p 4 8}{cmd:cov_partition(}{it:#}{cmd:)}, when covariates are provided, it specifies the number of clusters in a kmedians algorithm to partition the covariate space. Covariates are used to tighten the bounds. 
Default is {cmd:cov_partition(6)}{p_end}

{p 4 8}{cmd:level(}{it:#}{cmd:)} specifies the significance level for the confidence intervals.
Default is {cmd:level(95)}{p_end}

{p 4 8}{cmd:nograph}, if specified omits display of graph.{p_end}

{p 4 8}{cmd:seed(}{it:#}{cmd:)} sets the seed for the kmedians initialization for the partition of the covariate space.{p_end}

{p 4 8}{cmd:qbounds}, when specified, this options computes bounds for the quantile treatment effect function. We do not provide confidence intervals for the quantile function bounds. In practice this is computationally more efficient and can be combined with permutation inference like bootstrapping.{p_end}

{p 4 8}{cmd:num_quantiles(}{it:#}{cmd:)} specifies the number of quantiles (q) in an equally spaced partition of [0,1].
Default is {cmd:num_quantiles(100)}{p_end}


{hline}


{marker examples}{...}
{title: Examples}

{title: "The limits of self-commitment and private paternalism"}

{p 4 8}Setup{p_end}
{p 8 8}{stata "use limits_commitment.dta, clear"}{p_end}

{p 4 8}Average treatment effect{p_end}
{p 8 8}{stata "regress apr treat, robust"}{p_end}

{p 4 8}Bounds for the treatment effect{p_end}
{p 8 8}{stata "fan_park apr treat"}{p_end}

{p 4 8}Bounds for the quantile-treatment effect{p_end}
{p 8 8}{stata "fan_park apr treat, qbounds"}{p_end}

{title: Simulation Example}

{p 8 8}{stata "do simulation_fan_park.do"}{p_end}


{marker stored_results}{...}
{title:Stored results}

{p 4 8}{cmd:rdrobust} stores the following in {cmd:r()}:

{synoptset 20 tabbed}{...}

{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(bounds)}}matrix of size (n X 2) where n denotes the number of points where the bounds are computed. The first column stores the estimated lower bound, while the second column stores the upper bound at each of the points. If option {cmd:qbounds} is provided {cmd:r(bounds)} stores the quantile bounds.{p_end}
{synopt:{cmd:r(sigma_2)}}matrix of size (n X 2). First column denotes the estimated variance for the lower bound at each of the points provided, and the second column stores the estimated variance for the upper bound.{p_end}
{synopt:{cmd:r(M_delta)}}matrix of size (n X 2). First column stores M(delta) = sup{F_1(y)-F_0(y-delta)}, and second column stores m(delta) = inf{F_1(y)-F_0(y-delta)}. For further details, see Fan, and Park (2009). {p_end}
{synopt:{cmd:r(delta_val)}}matrix of size (n X 1). Stores the points in the support of (Y_1-Y_0) where the bounds are computed{p_end}
{synopt:{cmd:r(q_val)}}matrix of size (n X 1). Stores the quantiles used to compute the q-bounds.{p_end}

{marker references}{...}
{title:References}

{p 4 8}{browse "https://doi.org/10.1017/S0266466609990168": Fan, Yanqin, and Sang Soo Park.} "SHARP BOUNDS ON THE DISTRIBUTION OF TREATMENT EFFECTS AND THEIR STATISTICAL INFERENCE." Econometric Theory, vol. 26, no. 3, 2010, pp. 931–51.{p_end}


{marker authors}{...}
{title:Authors}

{p 4 8}Meza Lopez Isaac; ITAM, Mexico City.
{browse "mailto:isaac.meza@berkeley.edu":isaac.meza@berkeley.edu}.{p_end}