##' Eagerly await mongo's reponse
##'
##' Polls the socket connection for non-null value.
##' Assume that the first 4 bytes are a int32 describing the message length.
##' Attempt to read the message length.
##'
##' @param connection an open socket 
##' @param timeout how many tries to get a non-null

mongoResp <-
  function(conn, timeout=10){    
    for (i in 1:timeout){
      first.raw = readBin(con=conn, what='raw', n=4)
      msg.len = decode_int32(first.raw)
      if (msg.len > 0)
        break()
      if(i == timeout-1)
        stop("No word from mongo!")
    }
    msg = readBin(
      con=conn,
      what='raw',
      n=(msg.len-4)) # msg.len counts itself in the total message length

    c(first.raw, msg)
  }
