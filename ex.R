##' mongor example script
##' this is meant to give you a brief idea of how mongor can be used right now

library(mongor) # load mongor, etc.

mc = mongoConnect() # make a connection
## by default, these operations are on the 'test' db, collection 'foo'
##
## since MongoDB is document-based, you can insert lists with many different types
mongoInsert(mc, list(hello="world", apples=3, time=Sys.time())) # insert a document
mongoInsert(mc, list(hello="world", apples=89, time=Sys.time())) # insert a document
mongoInsert(mc, list(hello="earth", apples=91, time=Sys.time())) # insert a document
mongoInsert(mc, list(hello="earth", datums=2:20))

mongoInsert(mc, list(hello="mongo", bananas=5, hungry=TRUE)) # insert another document

## here are some examples of using mongo's document-based queries
## queries for documents for which hello = 'world'
## ignores those that don't have 'hello'
mongoFind(mc, list(hello='world'))
## find documents whose 'apples' is greater than 3 
mongoFind(mc, list(apples=list("$gt"=3)))
## find documents whose 'apples' is greater than 3 AND hello='world'
mongoFind(mc, list(apples=list("$gt"=3), hello=list("$in"=c("earth", "world"))))
## for more on querying, see
## http://www.mongodb.org/display/DOCS/Advanced+Queries

## mongoDelete deletes all documents that match the selector document
mongoFind(mc, list(bananas=5)) # it's there!
mongoDelete(mc, list(bananas=5))
mongoFind(mc, list(bananas=5)) # it's not there!
