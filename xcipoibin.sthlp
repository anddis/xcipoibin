{smcl}
{* *! version 1.0.0 24nov2017}{...}

{cmd:help xcipoibin}
{hline}

{title:Title}

{p2colset 5 18 19 2}{...}
{p2col :{hi:xcipoibin} {hline 2}}Exact confidence intervals for means of Poisson distributions and for proportions of Binomial distributions based on aggregate data{p_end}
{p2colreset}{...}


{title:Syntax}

{p 8 13 2}
{cmd:xcipoibin} {it:numvar} {it:denvar} {ifin}, [ {it:options} ]


{phang}
{it:numvar} is the variable name for the observed number of events / successes.

{phang}
{it:denvar} is the variable name for the total exposure (Poisson)[#] or the total number of observations (Binomial). If {opt poi:sson} is specified, this variable is optional and assumed to be equal to 1.

{phang}
[#] the total exposure is typically a time or an area during which the number of events recorded in {it:numvar} was observed. 


{synoptset 31 tabbed}{...}
{synopthdr :options}
{synoptline}
{p2coldent: * {opt poi:sson}}{it:numvar} are Poisson-distributed number of events{p_end}
{p2coldent: * {opt bin:omial}}{it:numvar} are Binomial-distributed number of successes{p_end}

{synopt :{opt per(#)}}multiplication factor for means/proportions{p_end}
{synopt :{opt level(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opth gen:erate(newvar:newvars)}}create {it:newvars} containing means/proportions, lower and upper confidence intervals{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}[*] either {opt poi:sson} or {opt bin:omial} is required.{p_end}


{title:Description}

{pstd}
{cmd:xcipoibin} calculates and stores in new variables the exact confidence intervals for means of Poisson- or proportions of Binomial-distributed random variables.

{pstd}
{cmd:xcipoibin} is useful for the analysis of aggregate data. The observations usually refer to different levels of one or more categorical variables (e.g.: calendar year, country).

{pstd}
{cmd:xcipoibin} can be used to calculate exact CIs for Incidence Rates (# events / total person-time), Standardized Incidence Ratios (# observed events / # expected events), or Cumulative Incidences (# events / total population) under Poisson or Binomial distributional assumptions. 

{pstd}
{cmd:xcipoibin} is useful to calculate exact CIs following commands that do not provide them. See for example {helpb strate}, which calculates normal-based CIs for IRs/SIRs on the log scale.

{pstd}
Note: the term "exact confidence interval" refers to its being derived from the Poisson or the Binomial distribution, i.e. the distribution exactly generating the data, rather than resulting in exactly the nominal coverage. The actual coverage probability is guaranteed to be greater than or equal to the nominal confidence level (see {helpb ci}).


{title:Options}

{phang}
{opt poi:sson} specifies that {it:numvar} contains Poisson-distributed number of events.

{phang}
{opt bin:omial} specifies {it:numvar} contains Binomial-distributed number of successes.

{phang}
{opt per(#)} multiplication factor for means/proportions.

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for confidence intervals. The default is {cmd:level(95)} or as set by {helpb set level}.

{phang}
{opth gen:erate(newvar:newvars)} sdd.


{title:Examples}

    {title:Incidence Rates (IRs)}

{pstd}Input data on prostate cancer cases by 5-year categories of attained age in 1998 [5].{p_end}
{phang2}{cmd:. clear}{p_end}
{phang2}{cmd:. input int calendar_year byte(age_category obs_pca_cases) int person_years}{p_end}
{phang2}{cmd:1998 45  1 6449}{p_end}
{phang2}{cmd:1998 50  1 8631}{p_end}
{phang2}{cmd:1998 55  8 7435}{p_end}
{phang2}{cmd:1998 60 26 6025}{p_end}
{phang2}{cmd:1998 65 36 6436}{p_end}
{phang2}{cmd:1998 70 48 5694}{p_end}
{phang2}{cmd:1998 75 49 4637}{p_end}
{phang2}{cmd:1998 80  4  346}{p_end}
{phang2}{cmd:end}{p_end}

{pstd}Calculate IRs per 100,000 person-years and exact 95% CIs, assuming that
 the number of events per category of attained age follows a Poisson distribution.{p_end}
{phang2}{cmd:. xcipoibin obs_pca_cases person_years, per(100000) gen(rate lowerCI upperCI) poisson}{p_end}

{pstd}List the results.{p_end}
{phang2}{cmd:. format rate lowerCI upperCI %9.2f}{p_end}
{phang2}{cmd:. list, noobs sep(0)}{p_end}


    {title:Standardized Incidence Ratios (SIRs)}

{pstd}Input data on observed and expected prostate cancer cases by calendar year (1998-2012) [5].{p_end}
{phang2}{cmd:. clear}{p_end}
{phang2}{cmd:. input int(calendar_year obs_pca_cases exp_pca_cases)}{p_end}
{phang2}{cmd:1998 173 168}{p_end}
{phang2}{cmd:1999 223 197}{p_end}
{phang2}{cmd:2000 226 212}{p_end}
{phang2}{cmd:2001 256 220}{p_end}
{phang2}{cmd:2002 258 232}{p_end}
{phang2}{cmd:2003 363 269}{p_end}
{phang2}{cmd:2004 329 293}{p_end}
{phang2}{cmd:2005 356 288}{p_end}
{phang2}{cmd:2006 275 269}{p_end}
{phang2}{cmd:2007 309 256}{p_end}
{phang2}{cmd:2008 303 246}{p_end}
{phang2}{cmd:2009 343 284}{p_end}
{phang2}{cmd:2010 281 257}{p_end}
{phang2}{cmd:2011 275 247}{p_end}
{phang2}{cmd:2012 243 221}{p_end}
{phang2}{cmd:end}{p_end}
	
{pstd}Calculate SIRs and exact 95% CIs, assuming that
 the number of events per calendar year follows a Poisson distribution.{p_end}
{phang2}{cmd:. xcipoibin obs_pca_cases exp_pca_cases, gen(sir lowerCI upperCI) poisson}{p_end}

{pstd}Plot the results.{p_end}
{phang2}{cmd:. tw (rcap upperCI lowerCI calendar_year, lc(black)) ///}{p_end}
{phang2}{cmd:(scatter sir calendar_year, m(Oh) mc(black)) , ///}{p_end}
{phang2}{cmd:legend(off) graphr(color(white) lw(thick) lc(white)) bgcolor(white) ///}{p_end}
{phang2}{cmd:xlabel(1998(1)2012, labsize(small)) ylabel(1(0.2)1.6, angle(horiz) format(%3.2f)) ///}{p_end}
{phang2}{cmd:ytitle("Standardized Incidence Ratio")  yscale(log) ///}{p_end}
{phang2}{cmd:xtitle("Calendar year")}{p_end}


    {title:Standardized Mortality Ratios (SIRs) following strate}

{pstd}Replicate example from {helpb strate}.{p_end}
{phang2}{cmd:. webuse diet}{p_end}
{phang2}{cmd:. stset dox, origin(time doe) id(id) scale(365.25) fail(fail==1 3 13)}{p_end}
{phang2}{cmd:. stsplit ageband, at(40(10)70) after(time=dob) trim}{p_end}
{phang2}{cmd:. merge m:1 ageband using http://www.stata-press.com/data/r15/smrchd}{p_end}
{phang2}{cmd:. strate ageband, per(1000) smr(rate) output(smr)}{p_end}

{pstd}Calculate exact 95% CIs.{p_end}
{phang2}{cmd:. use smr, clear}{p_end}
{phang2}{cmd:. xcipoibin _D _E, poisson gen(_SMR2 _Lower_XCT _Upper_XCT)}{p_end}

{pstd}List the results.{p_end}
{phang2}{cmd:. format _SMR2 _Lower_XCT _Upper_XCT %8.4f}{p_end}
{phang2}{cmd:. list, noobs sep(0) abbreviate(10)}{p_end}


{title:Stored results}

{pstd}
{cmd:xcipoibin} stores the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(per)}}multiplication factor{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(cmd)}}{cmd:xcipoibin}{p_end}
{synopt:{cmd:r(cmdline)}}command as typed{p_end}
{synopt:{cmd:r(numvar)}}variable name for the number of events / successes{p_end}
{synopt:{cmd:r(denvar)}}variable name for the exposure / total number of observations{p_end}
{synopt:{cmd:r(dist)}}{bf:poisson} or {bf:binomial}{p_end}
{synopt:{cmd:r(genvars)}}names of generated variables{p_end}


{title:References}

{phang}[1] Breslow N, Day NE. 1987. Statistical Methods in Cancer Research: Volume II, The Design and Analysis of Cohort Studies. Lyon: International Agency for Research on Cancer.

{phang}[2] StataCorp. 2015. Stata 14 Base Reference Manual. College Station, TX: Stata Press.

{phang}[3] {browse "https://ms.mcmaster.ca/peter/s743/poissonalpha.html":https://ms.mcmaster.ca/peter/s743/poissonalpha.html}

{phang}[4] Brown LD, Cai TT, and DasGupta A. 2001. Interval estimation for a binomial proportion. Statistical Science 16: 101–133.

{phang}[5] Discacciati A. 2015. Risk factors for prostate cancer: analysis of primary data, pooling, and related methodological aspects. Karolinska Institutet. {hline 2} {browse "http://hdl.handle.net/10616/44872": http://hdl.handle.net/10616/44872}


{title:Author}

{pstd}Andrea Discacciati, {it:Unit of Biostatistics, Karolinska Institutet, Stockholm, Sweden}{p_end}


{title:Also see}

{pstd}{helpb invpoisson()}, {helpb invbinomial()}, {helpb invbinomialtail()}, {helpb ci}, {bf:eclpci} (from SSC){p_end}
