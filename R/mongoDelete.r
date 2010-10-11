##' Updates a document
##'
##' Updates a document in a Mongo collection
##'
##' @export
##' @param doc the list to be sent

mongoDelete <-
  function(conn, selector, dbname="test", collection="foo"){
    mongoSend(op_delete(paste(dbname, collection, sep="."),
                        selector=selector), conn)
  }
