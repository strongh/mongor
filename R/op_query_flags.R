op_query_flags <-
function(){ # set flags for OP_QUERY
  pack('b', as.integer(rep(0, 32)))
}

