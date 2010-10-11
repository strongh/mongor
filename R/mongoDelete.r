##' Updates a document
##'
##' Updates a document in a Mongo collection
##'
##' @export
##' @param doc the list to be sent

mongoDelete <-
  function(conn, selector){
    mongoSend(op_delete(selector=selector), conn)
  }