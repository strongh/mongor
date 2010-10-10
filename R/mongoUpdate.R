##' Updates a document
##'
##' Updates a document in a Mongo collection
##'
##' @export
##' @param doc the list to be sent

mongoUpdate <-
  function(conn, selector, doc){
    mongoSend(op_update(selector, doc), conn)
  }

