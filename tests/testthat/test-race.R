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
  expect_equal(lucky$likely_race, "white")
  expect_equal(predict_race("smith", probability = FALSE)$likely_race, "white")
  expect_equal(smith$probability_american_indian, 0.0087)
  expect_equal(smith$probability_asian, 0.0045)
  expect_equal(smith$probability_black, 0.2267)
  expect_equal(smith$probability_hispanic, 0.0199)
  expect_equal(smith$probability_white, 0.7211)
  expect_equal(smith$probability_2races, 0.0191)


  expect_equal(lucky$probability_american_indian, 0.0061)
  expect_equal(lucky$probability_asian, 0.042)
  expect_equal(lucky$probability_black, 0.4466)
  expect_equal(lucky$probability_hispanic, 0.0231)
  expect_equal(lucky$probability_white, 0.4544)
  expect_equal(lucky$probability_2races, 0.0279)

  expect_equal(smith_lincoln$likely_race, c("white", "white"))
  expect_equal(predict_race(c("smith", "Lincoln"), probability = FALSE)$likely_race,
               c("white", "white"))
  expect_equal(smith_lincoln$probability_american_indian,
               c(0.0087, 0.0373))
  expect_equal(smith_lincoln$probability_asian,
               c(0.0045, 0.0125))
  expect_equal(smith_lincoln$probability_black,
               c(0.2267, 0.1421))
  expect_equal(smith_lincoln$probability_hispanic,
               c(0.0199, 0.0215))
  expect_equal(smith_lincoln$probability_white,
               c(0.7211, 0.7615))
  expect_equal(smith_lincoln$probability_2races,
               c(0.0191, 0.025))


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
  expect_equal(lincoln$probability_american_indian, 0.0373)
  expect_equal(lincoln$probability_asian, 0.0125)
  expect_equal(lincoln$probability_black, 0.1421)
  expect_equal(lincoln$probability_hispanic, 0.0215)
  expect_equal(lincoln$probability_white, 0.7615)
  expect_equal(lincoln$probability_2races, 0.025)

  expect_true(is.na(rlincoln$likely_race))
  expect_true(is.na(predict_race("RLincoln", probability = FALSE)$likely_race))
  expect_true(is.na(rlincoln$probability_american_indian))
  expect_true(is.na(rlincoln$probability_asian))
  expect_true(is.na(rlincoln$probability_black))
  expect_true(is.na(rlincoln$probability_hispanic))
  expect_true(is.na(rlincoln$probability_white))
  expect_true(is.na(rlincoln$probability_2races))

})
