##' Count objects in a collection
##'
##' Returns the number of documents
##'
##' @return count

mongoCount <-
  function(conn, query=list()){
    mongoRunCommand(conn,
                    "count",
                    list(count="foo",
                         query=query)
                    )[[1]]$n
  }

