##' Insert a document
##'
##' Inserts a document into a Mongo collection
##'
##' @param doc the list to be sent

mongoInsert <-
  function(conn, doc){
    mongoSend(op_insert(doc), conn)
  }

