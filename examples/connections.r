## mongor example script
## this is meant to give you a brief idea of how mongor can be used right now

library(mongor) # load mongor, etc.

mc <- mongoConnect() # make a connection
## since MongoDB is document-based, you can insert lists with many different types

## How to query and insert documents to a collection 
mongoInsert(mc,
            "test",
            "foo",
            list(hello="world",
                 apples=3,
                 time=Sys.time())) # insert a document

mongoInsert(mc,
            "test",
            "foo",
            list(hello="world", apples=89, time=Sys.time())) # insert a document
mongoInsert(mc, "test", "foo", list(hello="earth", apples=91, time=Sys.time())) # insert a document
mongoInsert(mc, "test", "foo", list(hello="earth", datums=2:20))

mongoInsert(mc, "test", "foo", list(hello="mongo", bananas=5, hungry=TRUE)) # insert another document

## here are some examples of using mongo's document-based queries
## queries for documents for which hello = 'world'
## ignores those that don't have 'hello'
mongoFind(mc, "test", "foo", list(hello='world'))
## find documents whose 'apples' is greater than 3 
mongoFind(mc, "test", "foo", list(apples=list("$gt"=3)))
## find documents whose 'apples' is greater than 3 AND hello='world'
mongoFind(mc, "test", "foo",
          list(apples=list("$gt"=3),
               hello=list("$in"=c("earth", "world"))))
## for more on querying, see
## http://www.mongodb.org/display/DOCS/Advanced+Queries

## mongoDelete deletes all documents that match the selector document
mongoFind(mc, "test", "foo", list(bananas=5)) # it's there!
mongoDelete(mc, "test", "foo", list(bananas=5))
mongoFind(mc, "test", "foo", list(bananas=5)) # it's not there!

## list databases on this host
listDb(mc)
## insert into a new database; mongo inits it for you
mongoInsert(mc, # insert another document...
            "endor", # into a database which doesn't yet exist!
            "foo",
            list(hello="mongo", bananas=5, hungry=TRUE))
## now look at everything in this new DB
mongoFind(mc, "endor", "foo", list())
## that's enough. let's drop this DB.
dropDb(mc, "endor")
## but is it _really_ gone?
listDb(mc)
## yes!


## commands are MongoDB operations. they include methods for
## maintenance, optimization, modes, and much more.
## for example, 
mongoRunCommand(mc, list(ping=1))
## mongoRunCommand will execute the mongo command and return the result.
## some commands must be run on the `admin' DB, while others can be run on
## any DB.
