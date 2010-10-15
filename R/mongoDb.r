##' Connect to a mongo DB
##'
##' Returns a socket connection with mongo on the other end.
##'
##' @export
##' @param dname database name
##' @param host the IP address where mongo is hosted
##' @param port the port where mongo is hosted
##' @return socket connection

mongoDb <-
  function(dbname, host="localhost", port=27017){
    db <- dbname 
    attr(db, "conn") <- mongoConnect(host=host, port=port)
    
    class(db) <- c("mongoDb", class(db))
    return(db)
  }

##'
##' @export

print.mongoDb <- function(db){
  conn <- summary(attr(db, "conn"))
  attr(db, "conn") <- NULL
  info <- strsplit(conn$description, ":")[[1]]
  cat("MongoDB", db,
      "\nOn host", substr(info[1], 3, nchar(info[1])), "and port", info[2], "\n")
}

##'
##' @export

summary.mongoDb <- function(db){
  print(db)
}

