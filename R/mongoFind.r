##' Sends and receices query
##'
##' Very exciting
##'
##' @export
##' @param connection
##' @param query
##' @return query results, as a list

mongoFind <- function(conn, query=list(), collection="test.foo"){
  mongoSend(op_query(collection=collection,
                     query_list=query,
                     to_return = 10), conn)
  
  rep = mongoReply(conn)

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
  function(conn, cmdDoc){
    mongoSend(op_query(collection="admin.$cmd",
                       query_list=cmdDoc,
                       to_return = 1), conn)
    mongoReply(conn)
  }
