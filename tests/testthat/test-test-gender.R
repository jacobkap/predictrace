


abbey        <- predictrace::predict_gender("abbey")
tyrion_jaime <- predictrace::predict_gender(c("tyrion", "JAIME"))
sansa        <- predictrace::predict_gender("sansa")
zzzjonsnow   <- predictrace::predict_gender("zzzjonsnow")
jorah        <- predictrace::predict_gender("jorah")
cedric       <- predictrace::predict_gender("cedric")



test_that("predict_gender for first name works", {

  expect_named(abbey, c("name",
                        "match_name",
                        "likely_gender",
                        "probability_female",
                        "probability_male"))
  expect_named(predict_gender("abbey", probability = FALSE), c("name",
                                                               "match_name",
                                                               "likely_gender"))
  expect_equal(abbey$likely_gender, "female")

  expect_equal(sansa$likely_gender, "female")
  expect_equal(predict_gender("sansa", probability = FALSE)$likely_gender, "female")
  expect_equal(sansa$probability_female, 1)
  expect_equal(sansa$probability_male, 0)


  expect_equal(jorah$probability_female, 0.26708, tolerance = 4)
  expect_equal(jorah$probability_male, 0.73290, tolerance = 4)

  expect_equal(tyrion_jaime$likely_gender, c("male", "male"))
  expect_equal(predict_gender(c("tyrion", "JAIME"), probability = FALSE)$likely_gender,
               c("male", "male"))
  expect_equal(tyrion_jaime$probability_female,
               c(0.011589, 0.420398), tolerance = 4)
  expect_equal(tyrion_jaime$probability_male,
               c(0.988411, 0.579602), tolerance = 4)

  expect_equal(cedric$likely_gender, "male")
  expect_equal(predict_gender("cedric", probability = FALSE)$likely_gender, "male")
  expect_equal(cedric$probability_female, 0.00677, tolerance = 4)
  expect_equal(cedric$probability_male, 0.99323, tolerance = 4)

  expect_true(is.na(zzzjonsnow$likely_gender))
  expect_true(is.na(predict_gender("zzzjonsnow", probability = FALSE)$likely_gender))
  expect_true(is.na(zzzjonsnow$probability_female))
  expect_true(is.na(zzzjonsnow$probability_male))

})
