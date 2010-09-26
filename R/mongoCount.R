mongoCount <-
function(attempts = 10){
  mongo_send(op_query())
  for(i in 1:attempts){
    tt = try(mongo_reply(), silent=TRUE)
    if(class(tt) != "try-error")
      break()
  }
  tt$n
}

