##' Send a command to Mongo
##'
##' Sends a command to Mongo.
##' See <URL> for documentation.
##'
##' @param attempts the number of times to try reading a response
##' @return an integer, a count of the collection's items.

mongoCount <-
function(attempts = 10){
  mongo_send(op_query())
  for(i in 1:attempts){
    tt = try(mongo_reply(), silent=TRUE)
    if(class(tt) != "try-error")
      break()
  }
  tt$n
}

