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
    dbs = mongoRunCommand(conn,
      list(listDatabases=1))[[1]]$databases
    ## returns more information... throw it away.
    ## inds picks out every third entry, which are the names
    inds = (1:(length(dbs)/3))*3-2
    
    dbs[inds]
  }


##' dropDb
##'
##' Drop the current database.
##'
##' @export
##' @param a mongoConnection

dropDb <-
  function(conn){
    mongoRunCommand(conn,
      list(dropDatabase=1))
  }
