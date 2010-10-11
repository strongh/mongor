##' OP_QUERY
##' 
##' One of the basic mongo messages.
##'
##' @param collection the name of the collection to query
##' @param query_list the query object, given as an R list
##' @return a raw vector encoding the query

op_query <-
  function(collection,
           doc=list(),
           to_return = 200){
    ## header
    flags <- op_query_flags()
    full_name <- encode_cstring(collection) # full collection name
    to_skip <- numToRaw(0, nBytes = 4)  # number of documents to skip
    to_return <- numToRaw(to_return, nBytes = 4) #number of entries to return
    query <- encode_document(doc) # empty query
    
    rawl <- c(flags, full_name, to_skip, to_return, query)
    
    header <- make_header(2004, length(rawl)) # make header last, so that it has the msgSize
    return(c(header, rawl))
  }


##' Make query flags
##'
##' Query flags are stored as a bit vector.
##' Most of them are 0.
##' See <URL>
##'
##' @param options options to include
##' @return raw vector 

op_query_flags <-
  function(options){ # set flags for OP_QUERY
    pack('b', as.integer(rep(0, 32)))
  }
