
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/predictrace)](https://cran.r-project.org/package=predictrace)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/jacobkap/predictrace?branch=master&svg=true)](https://ci.appveyor.com/project/jacobkap/predictrace)
[![Build
Status](https://travis-ci.org/jacobkap/predictrace.svg?branch=master)](https://travis-ci.org/jacobkap/predictrace)
[![Coverage
status](https://codecov.io/gh/jacobkap/predictrace/branch/master/graph/badge.svg)](https://codecov.io/github/jacobkap/predictrace?branch=master)
[![](http://cranlogs.r-pkg.org/badges/grand-total/predictrace?color=blue)](https://cran.r-project.org/package=predictrace)

## Overview

The goal of `predictrace` is to predict the race of a surname or first
name and the gender of a first name. This package uses U.S. Census data
which says how many people of each race has a certain surname. For first
name data, this package uses data from Tzioumis (2018). From this we can
predict which race is mostly likely to have that surname or first name.
The possible races are American Indian, Asian, Black, Hispanic, White,
or two or more races. For the gender of first names, this package uses
data from the United States Social Security Administration (SSA) that
tells how many people of a given name are female and how many are male
(no other genders are included). I use this to determine the proportion
of each gender a name is, and use the gender with the higher proportion
as the most likely gender for that name. Please note that the Census
data on the race of first names is far smaller than the SSA data on the
gender of first names, so you will match far fewer first names to race
than to gender.

Full citation for the Tzioumis data: Tzioumis, Konstantinos (2018)
Demographic aspects of first names, Scientific Data, 5:180025
\[dx.doi.org/10.1038/sdata.2018.25\].

## Installation

``` r
To install this package, use the code
install.packages("predictrace")


# The development version is available on Github.
# install.packages("devtools")
devtools::install_github("jacobkap/predictrace")
```

## Usage

``` r
library(predictrace)
```

### Race of a surname

To get the race of a surname, the only required parameter in
`predict_race()` is `name` which is the surname you want to find the
race of. Please note that this parameter only accepts surnames,
including both first and last name will result in not finding a match in
the Census data. This function returns the name you input, the named
matched through Census data, and likely race of that name, and the
probability that the name is of each race.

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

### Race of a first name

To get the race of a first name, you again use `predict_race()` but now
set the parameter `surname` to FALSE. This returns the exact same
results as above, but now only works for first names (you may still get
a match of a name if you don’t set the parameter to FALSE but that is
simply because some first names are also last names. The race results
will likely be incorrect.).

``` r
predict_race("sarah", surname = FALSE)
```

    ##    name match_name likely_race probability_american_indian probability_asian
    ## 1 sarah      sarah       white                      0.0014            0.0208
    ##   probability_black probability_hispanic probability_white probability_2races
    ## 1            0.0175               0.0189            0.9397             0.0017

This function accepts a single string or a vector of strings.

``` r
predict_race(c("sarah", "jaime", "jon", "bao"), surname = FALSE)
```

    ##    name match_name likely_race probability_american_indian probability_asian
    ## 1 sarah      sarah       white                      0.0014            0.0208
    ## 2 jaime      jaime    hispanic                      0.0013            0.0493
    ## 3   jon        jon       white                      0.0014            0.0190
    ## 4   bao        bao       asian                      0.0090            0.9640
    ##   probability_black probability_hispanic probability_white probability_2races
    ## 1            0.0175               0.0189            0.9397             0.0017
    ## 2            0.0045               0.4933            0.4497             0.0019
    ## 3            0.0073               0.0100            0.9616             0.0007
    ## 4            0.0000               0.0000            0.0180             0.0090

If you only want the most likely race and not the individual
probabilities of each race, set the parameter `probability` to FALSE.

``` r
predict_race("sarah", probability = FALSE, surname = FALSE)
```

    ##    name match_name likely_race
    ## 1 sarah      sarah       white

### Gender of a first name

To get the gender of a first name you use the `predict_gender()`
function and the only required parameter in `predict_gender()` is `name`
which is the first name you want to find the gender of. This function
returns the name you input, the named matched through SSA data, and
likely gender of that name, and the probability that the name is female
or male.

``` r
predict_gender("tyrion")
```

    ##     name match_name likely_gender probability_female probability_male
    ## 1 tyrion     tyrion          male          0.0115894        0.9884106

``` r
predict_gender(c("tyrion", "jaime", "jon", "sansa", "arya", "cersei"))
```

    ##     name match_name likely_gender probability_female probability_male
    ## 1 tyrion     tyrion          male        0.011589404        0.9884106
    ## 2  jaime      jaime          male        0.420397758        0.5796022
    ## 3    jon        jon          male        0.007450144        0.9925499
    ## 4  sansa      sansa        female        1.000000000        0.0000000
    ## 5   arya       arya        female        0.892700886        0.1072991
    ## 6 cersei     cersei        female        1.000000000        0.0000000

If you only want the most likely gender and not the individual
probabilities of each gender, set the parameter `probability` to FALSE.

``` r
predict_gender(c("tyrion", "jaime", "jon", "sansa", "arya", "cersei"), probability = FALSE)
```

    ##     name match_name likely_gender
    ## 1 tyrion     tyrion          male
    ## 2  jaime      jaime          male
    ## 3    jon        jon          male
    ## 4  sansa      sansa        female
    ## 5   arya       arya        female
    ## 6 cersei     cersei        female

In cases where there is no match in the data, it will return NA.

``` r
predict_gender("zzztyrion")
```

    ##        name match_name likely_gender probability_female probability_male
    ## 1 zzztyrion  zzztyrion          <NA>                 NA               NA
