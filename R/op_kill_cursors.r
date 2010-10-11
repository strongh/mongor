##' OP_KILL_CURSORS
##' 
##' One of the basic mongo messages.
##'
##' @param collection the name of the collection to query
##' @param cursor.ids a list of cursor ids
##' @return a raw vector encoding the query

op_kill_cursors <-
  function(collection='test.$cmd',
           cursor.ids,
           to_return = 10){
    ## header
    fut_use <- numToRaw(0, nBytes = 4) # reserved for future use
    full_name <- encode_cstring(collection) # full collection name
    id.count <- encode_int32(length(cursor.ids))
    cursor.id <- unlist(cursor.ids)
    
    rawl <- c(fut_use, full_name, id.count, cursor.id)
    
    header <- make_header(2007, length(rawl)) # make header last, so that it has the msgSize
    return(c(header, rawl))
  }
