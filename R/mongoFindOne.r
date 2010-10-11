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
  function(conn, query = list(), attempts = 10, dbname="test", collection="foo"){
    mongoSend(op_query(collection=paste(dbname, collection, sep="."),
                       doc=list(`$query`=query),
                       to_return=1), conn)
    rep = mongoReply(conn)
    
    rep
  }
