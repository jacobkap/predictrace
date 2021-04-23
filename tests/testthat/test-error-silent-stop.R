test_that("correct input works", {

  expect_silent(predict_race("smith"))
  expect_silent(predict_race(c("smith", "Lincoln")))
  expect_silent(predict_race("Ben smith"))
  expect_silent(predict_race("Lincoln"))
  expect_silent(predict_race("RLincoln"))


  expect_silent(predict_race("abbey",              surname = FALSE))
  expect_silent(predict_race(c("anibal", "KennY"), surname = FALSE))
  expect_silent(predict_race("jacob d",            surname = FALSE))
  expect_silent(predict_race("Doan",               surname = FALSE))
  expect_silent(predict_race("cedric",             surname = FALSE))


  expect_silent(predict_gender("harry"))
  expect_silent(predict_gender(c("harry", "hermione")))
  expect_silent(predict_gender("ron weasley"))
  expect_silent(predict_gender("tyrion"))
  expect_silent(predict_gender("TLanister"))

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



  expect_error(predict_race(2, surname = FALSE), "name must be a character type.")
  expect_error(predict_race(TRUE, surname = FALSE), "name must be a character type.")
  expect_error(predict_race(1:5, surname = FALSE), "name must be a character type.")
  expect_error(predict_race(as.factor(letters), surname = FALSE), "name must be a character type.")
  expect_error(predict_race(NA, surname = FALSE), "name must be a character type.")
  expect_error(predict_race(NULL, surname = FALSE), "name must be a character type.")


  expect_error(predict_race("smith", probability = 1, surname = FALSE),
               "probability must either be TRUE or FALSE.")
  expect_error(predict_race("smith", probability = letters, surname = FALSE),
               "probability must either be TRUE or FALSE.")
  expect_error(predict_race("smith", probability = mtcars, surname = FALSE),
               "probability must either be TRUE or FALSE.")
  expect_error(predict_race("smith", probability = c(TRUE, FALSE), surname = FALSE),
               "probability must either be TRUE or FALSE.")
  expect_error(predict_race("smith", probability = "cat", surname = FALSE),
               "probability must either be TRUE or FALSE.")
  expect_error(predict_race("smith", probability = NA, surname = FALSE),
               "probability must either be TRUE or FALSE.")
  expect_error(predict_race("smith", probability = NULL, surname = FALSE),
               "probability must either be TRUE or FALSE.")



  expect_error(predict_gender(2), "name must be a character type.")
  expect_error(predict_gender(TRUE), "name must be a character type.")
  expect_error(predict_gender(1:5), "name must be a character type.")
  expect_error(predict_gender(as.factor(letters)), "name must be a character type.")
  expect_error(predict_gender(NA), "name must be a character type.")
  expect_error(predict_gender(NULL), "name must be a character type.")


  expect_error(predict_gender("tyrion", probability = 1),
               "probability must either be TRUE or FALSE.")
  expect_error(predict_gender("tyrion", probability = letters),
               "probability must either be TRUE or FALSE.")
  expect_error(predict_gender("tyrion", probability = mtcars),
               "probability must either be TRUE or FALSE.")
  expect_error(predict_gender("tyrion", probability = c(TRUE, FALSE)),
               "probability must either be TRUE or FALSE.")
  expect_error(predict_gender("tyrion", probability = "cat"),
               "probability must either be TRUE or FALSE.")
  expect_error(predict_gender("tyrion", probability = NA),
               "probability must either be TRUE or FALSE.")
  expect_error(predict_gender("tyrion", probability = NULL),
               "probability must either be TRUE or FALSE.")
})
