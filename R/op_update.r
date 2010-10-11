##' OP_UPDATE
##'
##' See <URL>
##' This formats a message to be inserted into Mongo.
##'
##' @param doc list to be inserted
##' @return raw vector 

op_update <-
  function(selector, doc){
    ## header is sent first, but is added last
    fut_use <- numToRaw(0, nBytes = 4) # reserved for future use
    full_name <- encode_cstring('test.foo') # full collection name
    flags <- op_update_flags()
    
    selector <- encode_document(selector)
    to_update <- encode_document(doc)
    
    rawl <- c(fut_use, full_name, flags, selector, to_update)
    
    header <- make_header(2001, length(rawl))
    
    return(c(header, rawl))
  }


##' Make update flags
##'
##' Update flags are stored as a bit vector.
##' Most of them are 0.
##' See <URL>
##'
##' @param options options to include
##' @return raw vector 

op_update_flags <-
  function(options){ # set flags for OP_QUERY
    pack('b', as.integer(rep(0, 32)))
  }
