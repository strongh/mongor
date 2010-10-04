##' Connect to mongo
##'
##' Returns a socket connection with mongo on the other end.
##'
##' @param host the IP address where mongo is hosted
##' @param port the port where mongo is hosted
##' @return socket connection

mongoConnect <-
  function(host="localhost", port=27017){
    socketConnection(host=host,
                     port=port,
                     open='wb')
  }
