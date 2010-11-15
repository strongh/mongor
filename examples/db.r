library(mongor) # load mongor, etc.

## get a mongoDb object.
md = mongoDb("test")

## we can query on collections from this database,
## without re-specifiying the connection or databse
mongoFind(md, "foo", list(hello="world"))
mongoFind(md, "foo", list(apples=list("$gt"=3))) # where apples are greater than 3
