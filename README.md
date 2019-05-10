
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/race)](https://cran.r-project.org/package=race)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/jacobkap/race?branch=master&svg=true)](https://ci.appveyor.com/project/jacobkap/race)
[![Build
Status](https://travis-ci.org/jacobkap/race.svg?branch=master)](https://travis-ci.org/jacobkap/race)
[![Coverage
status](https://codecov.io/gh/jacobkap/race/branch/master/graph/badge.svg)](https://codecov.io/github/jacobkap/race?branch=master)
[![](http://cranlogs.r-pkg.org/badges/grand-total/race?color=blue)](https://cran.r-project.org/package=race)

## Overview

The goal of race is to predict the race of a surname. This package uses
U.S. Census data which says how many people of each race has a certain
surname. From this we can predict which race is mostly likely to have
that surname.

## Installation

``` r
To install this package, use the code
install.packages("race")


# The development version is available on Github.
# install.packages("devtools")
devtools::install_github("jacobkap/race")
```

## Usage

``` r
library(race)
```

``` r
race("Washington")
```

    ##         name match_name likely_race probability_american_indian
    ## 1 Washington washington       black                      0.0068
    ##   probability_asian probability_black probability_hispanic
    ## 1             0.003            0.8753               0.0254
    ##   probability_white probability_2races
    ## 1            0.0517             0.0378

If you only want the most likely race and not the individual
probabilities of each race, set the parameter `probability` to FALSE.

``` r
race("Washington", probability = FALSE)
```

    ##         name match_name likely_race
    ## 1 Washington washington       black
