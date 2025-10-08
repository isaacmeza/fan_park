{smcl}
{* *! version 1.0.2  10oct2025}{...}
{viewerjumpto "Syntax" "fan_park##syntax"}{...}
{viewerjumpto "Description" "fan_park##description"}{...}
{viewerjumpto "Options" "fan_park##options"}{...}
{viewerjumpto "Examples" "fan_park##examples"}{...}
{viewerjumpto "Stored results" "fan_park##stored_results"}{...}
{viewerjumpto "Remarks" "fan_park##remarks"}{...}
{viewerjumpto "References" "fan_park##references"}{...}
{viewerjumpto "Authors" "fan_park##authors"}{...}

{title:Title}

{p 4 8}{cmd:fan_park} {hline 2} Sharp bounds on the distribution (and quantile function) of treatment effects for a binary treatment, with optional covariate tightening and pointwise inference.

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
{synopthdr :Options}
{synoptline}
{synopt:{opt delta_partition(#)}}Number of grid points for the treatment-effect support when computing distribution-function bounds; default {cmd:100}.{p_end}
{synopt:{opt delta_values(numlist)}}Explicit grid of δ values at which to compute bounds. Values outside the feasible range are ignored. Supersedes {cmd:delta_partition()}.{p_end}
{synopt:{opt cov_partition(#)}}If {it:indepvars} are supplied, number of {it:k}-medians clusters used to partition covariate space (tightening the bounds); default {cmd:6}.{p_end}
{synopt:{opt level(#)}}Confidence level for pointwise CIs on distribution-function bounds; default {cmd:95}.{p_end}
{synopt:{opt nograph}}Suppress the graph.{p_end}
{synopt:{opt seed(#)}}Initialization for {cmd:cluster kmedians, start(krandom(#))}. If {cmd:seed(1)} (the default), a random seed is drawn internally; set a fixed integer to reproduce partitions.{p_end}
{synopt:{opt qbounds}}Compute bounds for the quantile function of treatment effects instead of the CDF. (No CIs are reported in this branch.){p_end}
{synopt:{opt num_quantiles(#)}}Number of equally spaced quantiles in [0,1] for {cmd:qbounds}; default {cmd:100}.{p_end}
{synoptline}

{marker description}{...}
{title:Description}

{pstd}
{cmd:fan_park} implements the sharp, nonparametric bounds on the distribution of treatment effects for a binary treatment developed by Fan and Park (2010, Econometric Theory). Let {it:Δ = Y1 − Y0}. Given the marginal distributions {it:F1} and {it:F0}, the program estimates pointwise sharp bounds
{it:F^L(δ) ≤ F_Δ(δ) ≤ F^U(δ)} over a grid of δ values. With the option {cmd:qbounds}, it instead computes bounds on the quantile function {it:F^{-1}_Δ(q)}:
{it:F^{-1,U}(q) ≤ F^{-1}_Δ(q) ≤ F^{-1,L}(q)}.

{pstd}
When {it:indepvars} are provided, the covariate space is partitioned by {cmd:cluster kmedians}, conditional bounds are computed within each cell using cell-specific supports, and then averaged with empirical cell weights. The final reported bounds intersect the unconditional and the averaged-conditional bounds, which can tighten the region under covariate heterogeneity and overlapping-support restrictions.

{marker arguments}{...}
{title:Arguments}

{phang}
{it:depvar} is the outcome. Continuous outcomes are typical, but binary outcomes are allowed.

{phang}
{it:treatvar} is a numeric indicator {cmd:0/1}. The command verifies this within the estimation sample.

{phang}
{it:indepvars} is an optional list of covariates (numeric). Factor-variable notation is not expanded here; pass numeric covariates or pre-built dummies.

{marker options}{...}
{title:Options}

{phang}
{cmd:delta_partition(#)} sets the number of δ grid points used to approximate the support of {it:Δ = Y1 − Y0}. The grid is the equally spaced partition of [{it:a−d}, {it:b−c}], where {it:[a,b]} is the support of {it:Y1} and {it:[c,d]} of {it:Y0}, estimated from the sample.

{phang}
{cmd:delta_values(numlist)} specifies explicit δ values. Values outside [{it:a−d}, {it:b−c}] are dropped. This option overrides {cmd:delta_partition()}.

{phang}
{cmd:cov_partition(#)} chooses the number of clusters for {cmd:cluster kmedians} over {it:indepvars}. Cells with no treated or no controls are skipped (positivity). Weights are the empirical cell shares among usable cells and are re-normalized.

{phang}
{cmd:level(#)} sets the confidence level for pointwise CIs on the distribution-function bounds. The graph shows shaded 95% and 90% bands (by default).

{phang}
{cmd:nograph} suppresses the graph.

{phang}
{cmd:seed(#)} passes through to {cmd:start(krandom(#))} for {cmd:cluster kmedians}. With the default {cmd:seed(1)}, a random integer seed is drawn internally; specify a fixed integer (e.g., {cmd:seed(12345)}) for replication.

{phang}
{cmd:qbounds} requests bounds for the quantile function of {it:Δ}. No standard errors/CIs are computed in this branch (you may bootstrap if the bound is interior).

{phang}
{cmd:num_quantiles(#)} sets the number of quantile grid points in [0,1] for {cmd:qbounds}.

{marker examples}{...}
{title:Examples}

{title:Baseline usage}

{phang2}{stata "use limits_commitment.dta, clear"}{p_end}
{phang2}{stata "fan_park apr treat"}{p_end}

{title:With covariates (tighter bounds when supports differ by X)}

{phang2}{stata "fan_park apr treat age educ, cov_partition(6)"}{p_end}

{title:Specify δ grid explicitly}

{phang2}{stata "fan_park apr treat, delta_values(-10(0.5)10)"}{p_end}

{title:Quantile-function bounds}

{phang2}{stata "fan_park apr treat, qbounds num_quantiles(200)"}{p_end}

{title:Simulation}

{phang2}{stata "do simulation_fan_park.do"}{p_end}

{marker stored_results}{...}
{title:Stored results}

{pstd}{cmd:fan_park} stores the following in {cmd:r()}.

{synoptset 22 tabbed}{...}
{synopthdr :Matrices}
{synoptline}
{synopt:{cmd:r(bounds)}}For distribution-function bounds (default branch): an {it:n × 2} matrix with columns {it:LB} and {it:UB} evaluated at {cmd:r(delta_val)}. For {cmd:qbounds}: an {it:n × 2} matrix with quantile-function bounds {it:UB} and {it:LB} evaluated at {cmd:r(q_val)}.{p_end}
{synopt:{cmd:r(sigma_2)}}(Only when {cmd:qbounds} is {it:not} specified.) {it:n × 2} matrix of large-sample variances for the active lower and upper bound at each δ (columns {it:Var_L}, {it:Var_U}). These underlie the pointwise CIs shown in the graph.{p_end}
{synopt:{cmd:r(M_delta)}}(Distribution-function branch.) {it:n × 2} matrix; column 1 stores {it:M(δ) = sup_y [F1(y) − F0(y − δ)]}, column 2 stores {it:m(δ) = inf_y [F1(y) − F0(y − δ)]}.{p_end}
{synopt:{cmd:r(M_active)}}(Distribution-function branch.) {it:n × 2} matrix; the sup/inf values corresponding to the bound that is actually active at each δ after intersecting unconditional and conditional bounds (columns {it:M_L_active}, {it:M_U_active}).{p_end}
{synopt:{cmd:r(delta_val)}}(Distribution-function branch.) {it:n × 1} grid of δ values used for {cmd:r(bounds)}.{p_end}
{synopt:{cmd:r(q_val)}}(Quantile-function branch.) {it:n × 1} grid of quantiles in [0,1] used for {cmd:r(bounds)}.{p_end}
{synoptline}

{marker remarks}{...}
{title:Remarks}

{pstd}
{it:Computation.} The program builds empirical CDFs of {it:Y1} and {it:Y0+δ} via {cmd:cumul}, interpolates with {cmd:ipolate}, and searches the intersection support {it:Y_δ = [a,b] ∩ [c+δ, d+δ]}. With covariates, the same is done cell-by-cell using cell-specific supports {it:[a_c, b_c]} and {it:[c_c, d_c]} before averaging across cells by empirical shares.

{pstd}
{it:Interpretation.} {cmd:r(bounds)} contains the final (possibly tightened) bounds after intersecting unconditional and conditional averages. {cmd:r(M_delta)} reports the raw sup/inf from the unconditional step; {cmd:r(M_active)} reports the sup/inf corresponding to whichever bound is active at each δ (used for the CI one-sidedness switch).

{pstd}
{it:Positivity and empty cells.} A cluster with no treated or no controls is skipped; weights are re-normalized over the remaining cells and a note is printed. If all cells are dropped at a δ (rare), the conditional piece is set missing and the unconditional bound is reported.

{pstd}
{it:Inference.} CIs are pointwise (not uniform) and based on large-sample normal approximations. Shaded bands on the graph correspond to 95% and 90% intervals. For {cmd:qbounds}, CIs are not provided; if needed, consider bootstrap inference away from boundary cases.

{marker references}{...}
{title:References}

{pstd}
{browse "https://doi.org/10.1017/S0266466609990168":Fan, Yanqin, and Sang Soo Park} (2010). “Sharp bounds on the distribution of treatment effects and their statistical inference.” {it:Econometric Theory} 26(3): 931–951.

{marker authors}{...}
{title:Authors}

{pstd}
Isaac Meza López, Department of Economics, Harvard University.
{browse "mailto:isaacmezalopez@g.harvard.edu":isaacmezalopez@g.harvard.edu}
