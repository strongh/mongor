source('~/rbson/bson.R')

make_header = function(opCode, messageLength){
  return(c(
           numToRaw(16 + messageLength, nBytes = 4), # messageLength
           numToRaw(sample(3:100, 1), nBytes = 4), # request_id
           numToRaw(0, nBytes = 4), # responseTo
           numToRaw(opCode, nBytes = 4)) #opCode
         )
}

op_query_flags = function(){ # set flags for OP_QUERY
  pack('b', as.integer(rep(0, 32)))
}


op_msg = function(){
  rw = encode_cstring('hello')$rw  
  return(c(
           make_header(1000, length(rw)),
           rw
           ))
}

op_query = function(){
  ## header
##  fut_use = numToRaw(0, nBytes = 4) # reserved for future use
  flags = op_query_flags()
  full_name = encode_cstring('test.$cmd') # full collection name
  to_skip = numToRaw(0, nBytes = 4)  # number of documents to skip
  to_return = numToRaw(1, nBytes = 4) #number of entries to return
  query = encode_document(list(count='foo', query=list(), fields=NULL)) # empty query
  
  rawl = c(flags, full_name, to_skip, to_return, query)

  header = make_header(2004, length(rawl)) # make header last, so that it has the msgSize
  return(c(header, rawl))
}

op_insert = function(){
  ## header is sent first, but is added last
  fut_use = numToRaw(0, nBytes = 4) # reserved for future use
  full_name = encode_cstring('test.foo') # full collection name
  to_insert = encode_document(list(thurs='hungry'))
  
  rawl = c(fut_use, full_name, to_insert)

  header = make_header(2002, length(rawl))
  
  return(c(header, rawl))
}


mongo_send = function(msg){
  writeBin(msg, sock, 1, endian="little")
}


mongo_get = function(){
#  osock = socketConnection(port=27017, open='wb')
  str = ''
  repeat{
    nxt = suppressWarnings(rawToChar(readBin(con=sock, what='raw')))

    if (nchar(nxt) > 0)
      str = paste(str, nxt, sep="")
    else
      break()
  }
  return(str)
}

mongo_reply = function(){
  msg.size = decode_int32(readBin(con=sock, what='raw', n=4)) # first int32, size of message
  msg = readBin(con=sock, what='raw', n=(msg.size-4))

  ## rest of header
  request.id = msg[1:4]
  msg = msg[-c(1:4)]

  response.to = msg[1:4]
  msg = msg[-c(1:4)]

  op.code = msg[1:4]
  msg = msg[-c(1:4)]
  ## end header

  ## op_reply
  
  response_flags = msg[1:4]
  msg = msg[-c(1:4)]
  
  cursor.id = msg[1:8] # int64
  msg = msg[-c(1:8)]
  
  starting.from = msg[1:4]
  msg = msg[-c(1:4)]

  num.returned = msg[1:4]
  msg = msg[-c(1:4)]

  out = decode_document(msg)

  out
}
