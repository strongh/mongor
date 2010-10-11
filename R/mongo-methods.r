##' Mongo methods
##'
##' @export

print.mongoResult <- function(x){
  attr(x, "cursor.id") <- NULL
  print(unclass(x))
  invisible(x)
}

summary.mongoResult <- function(x){
  cat(length(x), "documents returned from MongoDB\n")
  cat("Cursor ID: ", attr(x, "cursor.id"), "\n")
  
  print(x)
}

print.mongoCollection <- function(x){
  attr(x, "db.name") <- "test"
  attr(x, "collection.name") = "foo"
  print(unclass(x))
  invisible(x)
}

summary.mongoCollection <- function(x){
  print(x)
}

