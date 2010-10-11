context("connecting to the database")


test_that("connection is made", {
  mc <- mongoConnect()
  expect_that(mongoRunCommand(mc, list(ping=1))[[1]]$ok,
              equals(1))
  close(mc)
})

test_that("insertion, querying, and deletion work", {
  mc <- mongoConnect()
  
  doc <- list(xxxxxxx=4, y="hi mongo")
  
  mongoInsert(mc,
              doc)
  
  expect_equal(mongoFind(mc, list(xxxxxxx=list("$gt"=3, "$lt"=6)))[[1]]$y,
               "hi mongo")

  close(mc)
})

