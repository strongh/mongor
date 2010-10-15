##' Connect to a mongo collection
##'
##' Returns a mongo collection object.
##' This necessarily specifies both the Mongo server and a DB on that server.
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
    
    db
  }

##'
##' @export
mongoCollection <-
  function(collection, dbname, host="localhost", port=27017){
    coll <- collection
    attr(coll, "dbname" ) <- dbname
    attr(coll, "conn") <- mongoConnect(host=host, port=port)

    class(coll) <- c("mongoCollection", class(coll))

    coll
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

##'
##' @export

`[.mongoCollection` <- function(collection, ...){
  query <-
    if (class(match.call()[3])=="call")
      list()
    else
      list(...)
  collection.name <- as.character(collection)
  dbname <- attr(collection, "dbname")
  conn <- attr(collection, "conn") 
  
  rep <- mongoFind.default(conn, dbname, collection, query)   
  
  rep
}
