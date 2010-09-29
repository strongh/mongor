##' Insert a document
##'
##' Inserts a document into a Mongo collection
##'
##' @param doc the list to be sent
##' @return the (updated) number of items in the collection

mongoInsert <-
  function(conn, doc){
    mongoSend(op_insert(doc), conn)

  }

