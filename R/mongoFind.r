##' Sends and returns query
##'
##' Very exciting
##'
##' @export
##' @param connection
##' @param query
##' @return query results, as a list

mongoFind <- function(...){
  UseMethod("mongoFind")
}


##'
##' @export

mongoFind.mongoCollection <- function(collection, query){
  collection.name <- as.character(collection)
  dbname <- attr(collection, "dbname")
  conn <- attr(collection, "conn") 
  
  rep <- mongoFind.default(conn, dbname, collection, query)   
  
  rep
}


##'
##' @export

mongoFind.mongoDb <- function(db, query=list()){
  dbname <- as.character(db)
  conn <- attr(db, "conn") 
  mongoSend(op_query(collection=paste(dbname, collection, sep="."),
                     doc=query,
                     to_return = 10), conn)  
  rep <- mongoReply(conn)
  
  rep
}

##'
##' @export
mongoFind.default <- function(conn, dbname, collection, query){
  mongoSend(op_query(collection=paste(dbname, collection, sep="."),
                     doc=query,
                     to_return = 10), conn)
  
  rep <- mongoReply(conn)
  
  rep 
}

##' Runs command and gets result
##'
##' Very exciting
##'
##' @export
##' @param connection
##' @param command
##' @return command results, as a list

mongoRunCommand <-
  function(conn, cmdDoc, dbname="admin"){
    mongoSend(op_query(collection=paste(dbname, ".$cmd", sep=""),
                       doc=cmdDoc,
                       to_return = 1), conn)
    mongoReply(conn)
  }
