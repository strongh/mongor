##' Send a BSON object to Mongo
##'
##' @param msg BSON object, encoded as a raw vector
##' @return success 

mongo_send <-
  function(msg){
    writeBin(msg, sock, 1, endian="little")
  }

