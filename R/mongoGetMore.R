##' Gets more from cursor
##'
##' Very exciting
##'
##' @export
##' @param connection
##' @param query an old query that you want to continue getting results from
##' @return more results

mongoGetMore <- function(connection, query){
  mongoSend(op_getmore(cursor.id = attr(query, "cursor.id")), connection)
  mongoReply(connection)  
}
