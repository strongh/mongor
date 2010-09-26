mongoInsert <-
function(doc){
  mongo_send(op_insert(doc))
  mongoCount()
}

