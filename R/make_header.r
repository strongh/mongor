##' Make a message header
##'
##' All messages to and from Mongo begin with a header of the form:
##'
##' int32 - total length of the message
##' int32 - a request ID, which is randomly generated
##' int32 - the request ID of message to which this is responding (not applicable to any messages sent to mongo)
##' int32 - the operation code, which encodes the message type
##'
##' @param opCode the operation code for this message
##' @param messageLength the length of message (sans header), in bytes
##' @return a raw vector

make_header <-
  function(opCode, messageLength){
    return(c(
             numToRaw(16 + messageLength, nBytes = 4), # messageLength
             numToRaw(sample(3:100, 1), nBytes = 4), # request_id
             numToRaw(0, nBytes = 4), # responseTo
             numToRaw(opCode, nBytes = 4)) #opCode
           )
  }
