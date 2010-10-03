##' OP_INSERT
##'
##' See <URL>
##' This formats a message to be inserted into Mongo.
##'
##' @param doc list to be inserted
##' @return raw vector 

op_insert <-
  function(doc){
    ## header is sent first, but is added last
    fut_use = numToRaw(0, nBytes = 4) # reserved for future use
    full_name = encode_cstring('test.foo') # full collection name
    to_insert = encode_document(doc)
    
    rawl = c(fut_use, full_name, to_insert)
    
    header = make_header(2002, length(rawl))
  
    return(c(header, rawl))
  }

