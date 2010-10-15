##' Send a raw message to Mongo
##'
##' Sends a message over a connection
##'
##' @param msg a raw vector
##' @param conn a socket connection

mongoSend <-
  function(msg, conn){
    flush(conn)
    writeBin(msg, conn, 1, endian="little")
  }

