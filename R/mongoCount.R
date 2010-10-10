##' Count objects in a collection
##'
##' Returns the number of documents
##'
##' @export
##' @return count

mongoCount <-
  function(conn, query=list()){
    mongoRunCommand(conn,
                    list(count="$cmd",
                         query=query)
                    )
  }

