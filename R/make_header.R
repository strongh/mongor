make_header <-
function(opCode, messageLength){
  return(c(
           numToRaw(16 + messageLength, nBytes = 4), # messageLength
           numToRaw(sample(3:100, 1), nBytes = 4), # request_id
           numToRaw(0, nBytes = 4), # responseTo
           numToRaw(opCode, nBytes = 4)) #opCode
         )
}

