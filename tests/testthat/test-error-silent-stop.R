test_that("correct input works", {

  expect_silent(predict_race("smith"))
  expect_silent(predict_race(c("smith", "Lincoln")))
  expect_silent(predict_race("Ben smith"))
  expect_silent(predict_race("Lincoln"))
  expect_silent(predict_race("RLincoln"))

})


test_that("wrong imput errors", {

  expect_error(predict_race(2), "name must be a character type.")
  expect_error(predict_race(TRUE), "name must be a character type.")
  expect_error(predict_race(1:5), "name must be a character type.")
  expect_error(predict_race(as.factor(letters)), "name must be a character type.")
  expect_error(predict_race(NA), "name must be a character type.")
  expect_error(predict_race(NULL), "name must be a character type.")


  expect_error(predict_race("smith", probability = 1),
                "probability must either be TRUE or FALSE.")
  expect_error(predict_race("smith", probability = letters),
                "probability must either be TRUE or FALSE.")
  expect_error(predict_race("smith", probability = mtcars),
                "probability must either be TRUE or FALSE.")
  expect_error(predict_race("smith", probability = c(TRUE, FALSE)),
                "probability must either be TRUE or FALSE.")
  expect_error(predict_race("smith", probability = "cat"),
                "probability must either be TRUE or FALSE.")
  expect_error(predict_race("smith", probability = NA),
                "probability must either be TRUE or FALSE.")
  expect_error(predict_race("smith", probability = NULL),
                "probability must either be TRUE or FALSE.")

})
