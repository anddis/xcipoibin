*! xcipoibin.ado
*! Andrea Discacciati
*! version 1.0.0 - 24nov2017

capture program drop xcipoibin
program define xcipoibin, rclass
	version 12	
	syntax varlist(min=1 max=2 numeric) [if] [in] [, GENerate(string) PER(integer 1) Level(cilevel) BINomial POIsson ] 
	
	marksample touse
	
	//---Begin Checks
	if "`binomial'"=="binomial" & "`poisson'"=="poisson" {
		di as err "Only one of {bf:binomial} or {bf:poisson} is allowed"
		exit 198
	}
	if "`binomial'"=="" & "`poisson'"=="" {
		di as err "Specify {bf:binomial} or {bf:poisson}"
		exit 198
	}
	
	local numvarlist : word count `varlist'
	if "`binomial'"=="binomial" & `numvarlist'==1 {
		di as err "Too few variables specified"
		exit 102
	}

	tokenize `varlist'
	local num `1'
	local den `2'
	if "`den'" == "" {
		tempvar den
		gen `den' = 1
	}
	
	tempvar checkintnum checkintden
	qui gen `checkintnum' = int(`num') if `touse'
	cap assert `checkintnum'==`num' & `num'>=0 if `touse'
	if _rc != 0 {
		di as err "Number of events/successes must be a nonnegative integer (variable `num')"
		exit 7
	}
	if "`binomial'"=="binomial" {
		qui gen `checkintden' = int(`den') if `touse'
		cap assert `checkintden'==`den' & `den'>0 if `touse' 
		if _rc != 0 {
			di as err "Number of observations must be a positive integer (variable `den')"
			exit 7
		}
	}
	if "`poisson'"=="poisson" {
		cap assert `den'>0 if `touse'
		if _rc != 0 {
			di as err "Exposure must be a positive integer (variable `den')"
			exit 7
		}
	}
	
	if "`generate'" != "" {
		local numgen : word count `generate'
		if `numgen' != 3 {
			di as err "Specify 3 variables in the generate() option"
			exit 102
		}
	}
	else {
		local generate "_pointestimate _lowerCI _upperCI"
	}
	
	cap assert `per' > 0 
	if _rc!= 0{
		di as err "Argument of option {bf:per()} must be a positive number"
		exit 7
	}
	//---End checks
	

	foreach var of local generate {
		confirm new variable `var'
	}
	tokenize `generate'
	local pestim `1'
	local lowerb `2'
	local upperb `3'
	

	local alph = (100-`level')/200
	
		gen double `pestim' = (`num'/`den')*`per' if `touse'
		
	if "`poisson'"=="poisson" {
		qui gen double `lowerb' = cond(`num'==0, 0, invpoisson(`num'-1, 1-`alph')/`den'*`per')  if `touse'
		qui gen double `upperb' = invpoisson(`num',`alph')/`den'*`per'  if `touse'
		local inlabel1 Means
		local inlabel2 Poisson
		
		qui count if `num'== 0 & `touse'
		if r(N) > 0 {
			di _n as text "Note: one-sided, " 100-(100-`level')/2 "% confidence intervals are calculated with 0 events"
		}
	}
	if "`binomial'"=="binomial" {
		qui gen double `lowerb' = cond(`num'==0, 0, invbinomialtail(`den', `num', `alph')*`per') if `touse'
		qui gen double `upperb' = cond(`num'==`den', 1, invbinomial(`den', `num', `alph')*`per') if `touse'
		local inlabel1 Proportions
		local inlabel2 Binomial
		
		qui count if (`num'== 0 | `num'==`den') & `touse'
		if r(N) > 0 {
			di _n as text "Note: one-sided, " 100-(100-`level')/2 "% confidence intervals are calculated with 0 successes or 0 failures"
		}
	}
	
	label var `pestim' "`inlabel1' `=cond(`per'!=1, "(per `per')", "")'"
	label var `lowerb' "Lower `level'% `inlabel2' Exact CIs"
	label var `upperb' "Upper `level'% `inlabel2' Exact CIs"
	
	
	return scalar per = 	`per'
	
	return local genvars 	"`generate'"
	return local dist 		`=cond("`binomial'"=="binomial", "binomial", "poisson")'
	return local denvar 	"`den'"
	return local numvar 	"`num'"
	return local cmdline 	"xcipoibin `0'"
	return local cmd 		"xcipoibin"
	
	
end
