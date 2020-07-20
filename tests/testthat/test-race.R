smith         <- predictrace::predict_race("smith")
smith_lincoln <- predictrace::predict_race(c("smith", "Lincoln"))
ben_smith     <- predictrace::predict_race("Ben smith")
lincoln       <- predictrace::predict_race("Lincoln")
rlincoln      <- predictrace::predict_race("RLincoln")
perez         <- predictrace::predict_race("Perez")
lucky         <- predictrace::predict_race("lucky")

test_that("predict_race works", {

  expect_named(smith, c("name",
                        "match_name",
                        "likely_race",
                        "probability_american_indian",
                        "probability_asian",
                        "probability_black",
                        "probability_hispanic",
                        "probability_white",
                        "probability_2races"))
  expect_named(predict_race("smith", probability = FALSE), c("name",
                                                     "match_name",
                                                     "likely_race"))

  expect_equal(smith$likely_race, "white")
  expect_equal(perez$likely_race, "hispanic")
  expect_equal(lucky$likely_race, "black, white")
  expect_equal(predict_race("smith", probability = FALSE)$likely_race, "white")
  expect_equal(smith$probability_american_indian, 0.0089)
  expect_equal(smith$probability_asian, 0.005)
  expect_equal(smith$probability_black, 0.2311)
  expect_equal(smith$probability_hispanic, 0.024)
  expect_equal(smith$probability_white, 0.709)
  expect_equal(smith$probability_2races, 0.0219)


  expect_equal(lucky$probability_american_indian, 0.0078)
  expect_equal(lucky$probability_asian, 0.0621)
  expect_equal(lucky$probability_black, 0.436)
  expect_equal(lucky$probability_hispanic, 0.0291)
  expect_equal(lucky$probability_white, 0.436)
  expect_equal(lucky$probability_2races, 0.0291)

  expect_equal(smith_lincoln$likely_race, c("white", "white"))
  expect_equal(predict_race(c("smith", "Lincoln"), probability = FALSE)$likely_race,
               c("white", "white"))
  expect_equal(smith_lincoln$probability_american_indian,
               c(0.0089, 0.0368))
  expect_equal(smith_lincoln$probability_asian,
               c(0.005, 0.0135))
  expect_equal(smith_lincoln$probability_black,
               c(0.2311, 0.1471))
  expect_equal(smith_lincoln$probability_hispanic,
               c(0.024, 0.0251))
  expect_equal(smith_lincoln$probability_white,
               c(0.709, 0.749))
  expect_equal(smith_lincoln$probability_2races,
               c(0.0219, 0.0285))


  expect_true(is.na(ben_smith$likely_race))
  expect_true(is.na(predict_race("Ben smith", probability = FALSE)$likely_race))
  expect_true(is.na(ben_smith$probability_american_indian))
  expect_true(is.na(ben_smith$probability_asian))
  expect_true(is.na(ben_smith$probability_black))
  expect_true(is.na(ben_smith$probability_hispanic))
  expect_true(is.na(ben_smith$probability_white))
  expect_true(is.na(ben_smith$probability_2races))



  expect_equal(lincoln$likely_race, "white")
  expect_equal(predict_race("Lincoln", probability = FALSE)$likely_race, "white")
  expect_equal(lincoln$probability_american_indian, 0.0368)
  expect_equal(lincoln$probability_asian, 0.0135)
  expect_equal(lincoln$probability_black, 0.1471)
  expect_equal(lincoln$probability_hispanic, 0.0251)
  expect_equal(lincoln$probability_white, 0.749)
  expect_equal(lincoln$probability_2races, 0.0285)

  expect_true(is.na(rlincoln$likely_race))
  expect_true(is.na(predict_race("RLincoln", probability = FALSE)$likely_race))
  expect_true(is.na(rlincoln$probability_american_indian))
  expect_true(is.na(rlincoln$probability_asian))
  expect_true(is.na(rlincoln$probability_black))
  expect_true(is.na(rlincoln$probability_hispanic))
  expect_true(is.na(rlincoln$probability_white))
  expect_true(is.na(rlincoln$probability_2races))

})
