##' OP_GETMORE
##' 
##' One of the basic mongo messages.
##'
##' @param collection the name of the collection to query
##' @param query_list the query object, given as an R list
##' @return a raw vector encoding the query

op_getmore <-
  function(collection,
           cursor.id,
           to_return = 10){
    ## header
    fut_use <- numToRaw(0, nBytes = 4) # reserved for future use
    full_name <- encode_cstring(collection) # full collection name
    to_return <- numToRaw(to_return, nBytes = 4) #number of entries to return
    cursor.id <- cursor.id
    
    rawl <- c(fut_use, full_name, to_return, cursor.id)
    
    header <- make_header(2005, length(rawl)) # make header last, so that it has the msgSize
    return(c(header, rawl))
  }
