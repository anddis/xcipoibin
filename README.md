# xcipoibin
### A Stata command for exact confidence intervals for means of Poisson distributions and for proportions of Binomial distributions based on aggregate data

- Current version: `1.0.0` 
- Release date: `24nov2017`

---


### Description

`xcipoibin` calculates and stores in new variables the exact confidence intervals for means of Poisson- or proportions of Binomial-distributed random variables.

`xcipoibin` is useful for the analysis of aggregate data. The observations usually refer to different levels of one or more categorical variables (e.g.: calendar year, country).

`xcipoibin` can be used to calculate exact CIs for Incidence Rates (# events / total person-time), Standardized Incidence Ratios (# observed events / # expected events), or Cumulative Incidences (# events / total population) under Poisson or Binomial distributional assumptions.

Note: the term "exact confidence interval" refers to its being derived from the Poisson or the Binomial distribution, i.e. the distribution exactly generating the data, rather than resulting in exactly the nominal coverage. The actual coverage probability is guaranteed to be greater than or equal to the nominal confidence level (see `help ci`).


### Installation

- To install the current version of `xcipoibin` directly from GitHub, run:
```Stata
net install xcipoibin, from("https://raw.githubusercontent.com/anddis/xcipoibin/master/")
```
from within a web-aware Stata (version 13+).

- For older versions of Stata, download and extract the [zip file](https://github.com/anddis/xcipoibin/archive/master.zip) and then run:
```Stata
net install xcipoibin, from(mydir)
```
from within Stata, where *mydir* is the directory that containes the extracted files.

- After installation, see the help file:
```Stata
help xcipoibin
```

### Examples

Worked-out examples can be found here: [https://rawgit.com/anddis/xcipoibin/master/xcipoibin_ex.html](https://rawgit.com/anddis/xcipoibin/master/xcipoibin_ex.html). See also `help xcipoisson`.

### Author

Andrea Discacciati, Unit of Biostatistics, Karolinska Institutet, Stockholm, Sweden


### References

[1] Breslow N, Day NE. 1987. Statistical Methods in Cancer Research: Volume II, The Design and Analysis of Cohort Studies. Lyon: International Agency for Research on Cancer.

[2] StataCorp. 2015. Stata 14 Base Reference Manual. College Station, TX: Stata Press.

[3] [https://ms.mcmaster.ca/peter/s743/poissonalpha.html](https://ms.mcmaster.ca/peter/s743/poissonalpha.html)

[4] Brown LD, Cai TT, and DasGupta A. 2001. Interval estimation for a binomial proportion. Statistical Science 16: 101–133.

[5] Discacciati A. 2015. Risk factors for prostate cancer: analysis of primary data, pooling, and related methodological aspects. Karolinska Institutet --- [http://hdl.handle.net/10616/44872](http://hdl.handle.net/10616/44872)
