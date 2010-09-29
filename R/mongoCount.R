##' Count objects in a collection
##'
##' Returns the number of documents
##'
##' @return count

mongoCount <-
  function(attempts = 10){
    mongo_send(op_query(collection='test.$cmd',
                        query_list=list(
                          count='foo',
                          query=list(),
                          fields=NULL)))
    for(i in 1:attempts){
      tt = try(mongo_reply(), silent=TRUE)
      if(class(tt) != "try-error")
        break()
    }
    tt$n
  }

