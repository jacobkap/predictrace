test_that("correct input works", {

  expect_silent(race("smith"))
  expect_silent(race(c("smith", "Lincoln")))
  expect_silent(race("Ben smith"))
  expect_silent(race("Lincoln"))
  expect_silent(race("RLincoln"))

})


test_that("wrong imput errors", {

  expect_error(race(2), "name must be a character type.")
  expect_error(race(TRUE), "name must be a character type.")
  expect_error(race(1:5), "name must be a character type.")
  expect_error(race(as.factor(letters)), "name must be a character type.")
  expect_error(race(NA), "name must be a character type.")
  expect_error(race(NULL), "name must be a character type.")


  expect_error(race("smith", probability = 1),
                "probability must either be TRUE or FALSE.")
  expect_error(race("smith", probability = letters),
                "probability must either be TRUE or FALSE.")
  expect_error(race("smith", probability = mtcars),
                "probability must either be TRUE or FALSE.")
  expect_error(race("smith", probability = c(TRUE, FALSE)),
                "probability must either be TRUE or FALSE.")
  expect_error(race("smith", probability = "cat"),
                "probability must either be TRUE or FALSE.")
  expect_error(race("smith", probability = NA),
                "probability must either be TRUE or FALSE.")
  expect_error(race("smith", probability = NULL),
                "probability must either be TRUE or FALSE.")

})
