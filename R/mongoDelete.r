##' Updates a document
##'
##' Updates a document in a Mongo collection
##'
##' @export
##' @param conn a mongoConnection
##' @param dbname the dbname
##' @param collection the name of the collection
##' @param selector the query, as a list, to select records

mongoDelete <-
  function(conn, dbname, collection, selector){
    mongoSend(op_delete(paste(dbname, collection, sep="."),
                        selector=selector), conn)
  }
