##' OP_QUERY
##'
##' See <URL>
##' This formats a message as a query.
##'
##' @param collection collection to query 
##' @return raw vector

op_query <-
  function(
           collection='test.$cmd',
           query_list=list(count='foo', query=list(), fields=NULL))
{
  ## header
  flags = op_query_flags()
  full_name = encode_cstring(collection) # full collection name
  to_skip = numToRaw(0, nBytes = 4)  # number of documents to skip
  to_return = numToRaw(10, nBytes = 4) #number of entries to return
  query = encode_document(query_list) # empty query
  
  rawl = c(flags, full_name, to_skip, to_return, query)
  
  header = make_header(2004, length(rawl)) # make header last, so that it has the msgSize
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
