##' Get messages from mongo
##'
##' TODO:
##' Add a connection object and timeout
##'
##' @return a raw vector

mongo_get <-
  function(){
    ##  sock = socketConnection(port=27017, open='wb')
    str = ''
    repeat{
      nxt = suppressWarnings(rawToChar(readBin(con=sock, what='raw')))
      
      if (nchar(nxt) > 0)
        str = paste(str, nxt, sep="")
      else
        break()
    }
    return(str)
  }

