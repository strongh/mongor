##' Query Mongo
##'
##' Send a Mongo query object, given as an R list, and return the results.
##' See <URL> for complete documentation
##'
##' @export
##' @param query a list specifiying the query
##' @param attempts the number of time to try reading
##' @return a list of query results

mongoFindOne <-
  function(query = list(), attempts = 10){
    mongo_send(op_query(collection='test.foo',
                        query=list(`$query`=query)))
    for(i in 1:attempts){
      tt <- try(mongo_reply(), silent=TRUE)
      if(class(tt) != "try-error")
        break()
    }
    tt
  }

