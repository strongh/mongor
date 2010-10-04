##' Sends and receices query
##'
##' Very exciting
##'
##' @param connection
##' @param query
##' @return query results, as a list

mongoQuery <- function(conn, query, collection="test.foo"){
  mongoSend(op_query(collection=collection,
                     query_list=query,
                     to_return = 10), conn)

  rep = mongoReply(conn)

  rep
}

mongoRunCommand <-
  function(conn, command, optionList=list()){
    mongoSend(op_query(collection="test.$cmd",
                       query_list=optionList,
                       to_return = 1), conn)
    mongoReply(conn)
  }
