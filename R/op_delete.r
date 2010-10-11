##' OP_DELETE
##' 
##' One of the basic mongo messages.
##'
##' @param collection the name of the collection to query
##' @param query_list the query object, given as an R list

op_delete <-
  function(collection='test.foo',
           selector=list()){
    ## header
    fut_use <- numToRaw(0, nBytes = 4) # reserved for future use    
    full_name <- encode_cstring(collection) # full collection name
    flags <- op_delete_flags()

    selector <- encode_document(selector)
    
    rawl <- c(fut_use, full_name, flags, selector)
    
    header <- make_header(2006, length(rawl)) # make header last, so that it has the msgSize
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

op_delete_flags <-
  function(options){ # set flags for OP_QUERY
    pack('b', as.integer(rep(0, 32)))
  }
