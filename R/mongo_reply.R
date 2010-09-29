##' Revieve and parse a reply
##'
##' Uses lower-level mongoResp to read response from the socket connection.
##' Strips out the header and parses the document(s).
##'
##' @param conn a socket connection
##' @return list of objects from Mongo

mongoReply <-
  function(conn){
    msg = mongoResp(conn)

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

    num.returned = msg[1:4]
    msg = msg[-c(1:4)]

    print(paste("Found", decode_int32(num.returned)))
    
    out = list()
    while(length(msg) > 4){ # a document is at least 5 bytes
      next.doc.len = decode_int32(msg[1:4])
      if (next.doc.len == 1){# wtf, mongo
        msg = msg[-c(1:4)]      
        next()
      }
      doc = decode_document(msg[1:next.doc.len])
      msg = msg[-c(1:next.doc.len)]      
      doc = doc[-pmatch("_id", names(doc))]
      if (!is.null(unlist(doc))) # mongo sometimes returns empty docs?
        out = append(out, list(doc))    
    }
    
    out
  }


