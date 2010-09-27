##' Get a Mongo reply
##'
##' TODO:
##' replace mongo_get
##' add connection object
##' add timeout
##'
##' @return list of objects from Mongo

mongo_reply <-
  function(){
    
    msg.size = decode_int32(readBin(con=sock, what='raw', n=4)) # first int32, size of message
    msg = readBin(con=sock, what='raw', n=(msg.size-4))
    
    ## rest of header
    request.id = msg[1:4]
    msg = msg[-c(1:4)]

    response.to = msg[1:4]
    msg = msg[-c(1:4)]
    
    op.code = msg[1:4]
    msg = msg[-c(1:4)]
    ## end header
    
    ## op_reply
    
    response_flags = msg[1:4]
    msg = msg[-c(1:4)]
    
    cursor.id = msg[1:8] # int64
    msg = msg[-c(1:8)]
    
    starting.from = msg[1:4]
    msg = msg[-c(1:4)]
    
    num.returned = msg[1:4]
    msg = msg[-c(1:4)]
    
    out = list()
    
    while(length(msg) > 4){ # a document is at least 5 bytes
      next.doc.len = decode_int32(msg[1:4])
      doc = decode_document(msg[1:next.doc.len])
      
      doc = doc[-pmatch("_id", names(doc))]
      out = append(out, doc)    
      msg = msg[-c(1:next.doc.len)]
    }
    out
  }

