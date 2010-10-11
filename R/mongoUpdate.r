##' Updates a document
##'
##' Updates a document in a Mongo collection
##'
##' @export
##' @param doc the list to be sent

mongoUpdate <-
  function(conn, selector, doc, dbname="test", collection="foo"){
    mongoSend(op_update(paste(dbname, collection, sep="."), selector, doc), conn)
  }

