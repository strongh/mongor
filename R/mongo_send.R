mongo_send <-
function(msg){
  writeBin(msg, sock, 1, endian="little")
}

