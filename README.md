
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/predictrace)](https://cran.r-project.org/package=predictrace)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/jacobkap/predictrace?branch=master&svg=true)](https://ci.appveyor.com/project/jacobkap/predictrace)
[![Build
Status](https://travis-ci.org/jacobkap/predictrace.svg?branch=master)](https://travis-ci.org/jacobkap/predictrace)
[![Coverage
status](https://codecov.io/gh/jacobkap/predictrace/branch/master/graph/badge.svg)](https://codecov.io/github/jacobkap/predictrace?branch=master)
[![](http://cranlogs.r-pkg.org/badges/grand-total/predictrace?color=blue)](https://cran.r-project.org/package=predictrace)

## Overview

The goal of race is to predict the race of a surname or first name. This
package uses U.S. Census data which says how many people of each race
has a certain surname. For first name data, this package uses data from
Tzioumis (2018). From this we can predict which race is mostly likely to
have that surname or first name. The possible races are American Indian,
Asian, Black, Hispanic, White, or two or more races.

Full citation for the Tzioumis data: Tzioumis, Konstantinos (2018)
Demographic aspects of first names, Scientific Data, 5:180025
\[dx.doi.org/10.1038/sdata.2018.25\].

## Installation

``` r
To install this package, use the code
install.packages("predictrace")


# Th e development version is available on Github.
# install.packages("devtools")
devtools::install_github("jacobkap/predictrace")
```

## Usage

The only required parameter is `name` which is the surname you want to
find the race of. Please note that this parameter only accepts surnames,
including both first and last name will result in not finding a match in
the Census data.

``` r
library(predictrace)
```

``` r
predict_race("Washington")
```

    ##         name match_name likely_race probability_american_indian
    ## 1 Washington washington       black                      0.0066
    ##   probability_asian probability_black probability_hispanic probability_white
    ## 1            0.0028            0.8865               0.0202            0.0517
    ##   probability_2races
    ## 1             0.0323

This function accepts a single string or a vector of strings.

``` r
predict_race(c("Washington", "Franklin", "Lincoln"))
```

    ##         name match_name likely_race probability_american_indian
    ## 1 Washington washington       black                      0.0066
    ## 2   Franklin   franklin       white                      0.0085
    ## 3    Lincoln    lincoln       white                      0.0373
    ##   probability_asian probability_black probability_hispanic probability_white
    ## 1            0.0028            0.8865               0.0202            0.0517
    ## 2            0.0050            0.3828               0.0222            0.5577
    ## 3            0.0125            0.1421               0.0215            0.7615
    ##   probability_2races
    ## 1             0.0323
    ## 2             0.0238
    ## 3             0.0250

If you only want the most likely race and not the individual
probabilities of each race, set the parameter `probability` to FALSE.

``` r
predict_race("Washington", probability = FALSE)
```

    ##         name match_name likely_race
    ## 1 Washington washington       black
