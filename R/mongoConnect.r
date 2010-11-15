##' Connect to mongo
##'
##' Returns a socket connection with mongo on the other end.
##'
##' @export 
##' @param host the IP address where mongo is hosted
##' @param port the port where mongo is hosted
##' @return socket connection

mongoConnect <-
  function(host="localhost", port=27017){
    connected <- exists(paste(host, port, sep="-"), envir=mongoEnv)
    sock <- if(!connected) {# see if connection exists
      stopifnot(capabilities()["sockets"])
      sock <- try(socketConnection(host=host,
                                   port=port,
                                   open="wb"),
                  silent=TRUE)
      if (is(sock, "try-error"))
        stop("Could not connect to Mongo!")
      flush(sock)
      class(sock) <- c("mongoConnection", class(sock))
      assign(paste(host, port, sep="-"), sock, envir=mongoEnv)
    } else {
      get(paste(host, port, sep="-"), envir=mongoEnv)
    }

    sock
  }

##' environment to hold connections
##' and cursors. not exported.
mongoEnv = new.env()

##' Print method for Mongo connections
##'
##' Prints stuff for mongo.
##'
##' @param a mongoConnection 

print.mongoConnection <-
  function(conn){    
    print("connected to mongo!")
  }


##' listDb
##'
##' List of databases on this connection
##'
##' @export
##' @param a mongoConnection
##' @return character vector of DB names 

listDb <-
  function(conn){
    dbs <- mongoRunCommand(conn,
      list(listDatabases=1))[[1]]$databases
    ## returns more information... throw it away.
    ## inds picks out every third entry, which are the names
    inds <- (1:(length(dbs)/3))*3-2
    
    dbs[inds]
  }


##' dropDb
##'
##' Drop the current database.
##'
##' @export
##' @param conn mongoConnection
##' @param db name of database to drop

dropDb <-
  function(conn, db){
    rep <- mongoRunCommand(conn, dbname=as.character(db),
                           list(dropDatabase=1))[[1]]
    
    if(rep$ok==1)
      print(paste("MongoDB databse", rep$dropped, "dropped succesfully!"))
    else
      print("Something's wrong!")    
  }


##' buildInfo
##'
##' Get version number and other build information, for a server.
##'
##' @export
##' @param conn mongoConnection

buildInfo <-
  function(conn){
    mongoRunCommand(conn, list(buildinfo=1))[[1]]
  }

##' collStats
##'
##' Get stats about a collection.
##'
##' @export
##' @param conn mongoConnection
##' @param dbname the name of the database
##' @param collection the name of collection
##' @param scale an optional argument specifying the units of storage

collStats <-
  function(conn, dbname, collection, scale = 1){
    mongoRunCommand(conn,
                    dbname = dbname,
                    list(collStats=collection))[[1]]
  }


##' collCount
##'
##' Get the number of documents in the specified collection.
##'
##' @export
##' @param conn mongoConnection
##' @param dbname the name of the database
##' @param collection the name of collection

collCount <-
  function(conn, dbname, collection, query=list()){    
    argList <- list(count = collection)
    if (length(query) > 0)
      argList$query <- query
    
    mongoRunCommand(conn,
                    dbname = dbname,
                    argList)[[1]]$n
  }


##' collDistinct
##'
##' Get a list of distinct values for a key in a collection.
##' The optional query subsets the collection.
##'
##' @export
##' @param conn mongoConnection
##' @param dbname the name of the database
##' @param collection the name of collection
##' @param key the key whose distinct values to count

collDistinct <-
  function(conn, dbname, collection, key, query=list()){    
    argList <- list(distinct = collection,
                    key = key)
    if (length(query) > 0)
      argList$query <- query
    
    mongoRunCommand(conn,
                    dbname = dbname,
                    argList)[[1]]$values
  }


##' dbStats
##'
##' Get stats about a database
##'
##' @export
##' @param conn mongoConnection
##' @param dbname the name of the database

dbStats <-
  function(conn, dbname){    
    mongoRunCommand(conn,
                    dbname = dbname,
                    list(dbStats = 1))
  }


##' collDrop
##'
##' Drop a collection
##'
##' @export
##' @param conn mongoConnection
##' @param dbname the name of the database
##' @param collection the name of the collection to drop

collDrop <-
  function(conn, dbname, collection){    
    mongoRunCommand(conn,
                    dbname = dbname,
                    list(drop = collection))
  }

##' getLastError
##'
##' Get the status of the last operation on this connection
##'
##' @export
##' @param conn mongoConnection

getLastError <-
  function(conn){    
    mongoRunCommand(conn,
                    list(getLastError = 1))
  }

