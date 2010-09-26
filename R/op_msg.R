op_msg <-
function(){
  rw = encode_cstring('hello')$rw  
  return(c(
           make_header(1000, length(rw)),
           rw
           ))
}

