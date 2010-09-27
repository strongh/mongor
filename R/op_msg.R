##' OP_MSG
##'
##' See <URL>
##' This is a deprecated message.
##'
##' @return raw vector 

op_msg <-
  function(){
    rw = encode_cstring('hello')$rw  
    return(c(
             make_header(1000, length(rw)),
             rw
             ))
  }

