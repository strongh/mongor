##' Insert a document
##'
##' Inserts a document into a Mongo collection
##'
##' @export
##' @param doc the list to be sent

mongoInsert <-
  function(conn, doc, dbname="test", collection="foo"){
    mongoSend(op_insert(paste(dbname, collection, sep="."), doc), conn)
  }

