##' Mongo methods
##'
##' @export

print.mongoResult <- function(res){
  attr(res, "cursor.id") <- NULL
  print(unclass(res))
  invisible(res)
}

summary.mongoResult <- function(res){
  cat(length(res), "documents returned from MongoDB\n")
  cat("Cursor ID: ", attr(x, "cursor.id"), "\n")
  
  print(res)
}

print.mongoCollection <- function(coll){
  attr(coll, "db.name") <- "test"
  attr(coll, "collection.name") = "foo"
  print(unclass(coll))
  invisible(coll)
}

summary.mongoCollection <- function(coll){
  print(coll)
}
