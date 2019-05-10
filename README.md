
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
that surname. The possible races are American Indian, Asian, Black,
Hispanic, White, or two or more races.

## Installation

``` r
To install this package, use the code
install.packages("race")


# The development version is available on Github.
# install.packages("devtools")
devtools::install_github("jacobkap/race")
```

## Usage

The only required parameter is `name` which is the surname you want to
find the race of. Please note that this parameter only accepts surnames,
including both first and last name will result in not finding a match in
the Census data.

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

This function accepts a single string or a vector of strings.

``` r
race(c("Washington", "Franklin", "Lincoln"))
```

    ##         name match_name likely_race probability_american_indian
    ## 1 Washington washington       black                      0.0068
    ## 2   Franklin   franklin       white                      0.0083
    ## 3    Lincoln    lincoln       white                      0.0368
    ##   probability_asian probability_black probability_hispanic
    ## 1            0.0030            0.8753               0.0254
    ## 2            0.0054            0.3876               0.0270
    ## 3            0.0135            0.1471               0.0251
    ##   probability_white probability_2races
    ## 1            0.0517             0.0378
    ## 2            0.5438             0.0278
    ## 3            0.7490             0.0285

If you only want the most likely race and not the individual
probabilities of each race, set the parameter `probability` to FALSE.

``` r
race("Washington", probability = FALSE)
```

    ##         name match_name likely_race
    ## 1 Washington washington       black
