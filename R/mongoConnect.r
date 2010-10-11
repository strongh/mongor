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
    stopifnot(capabilities()["sockets"])
    sock <- try(socketConnection(host=host,
                             port=port,
                             open="wb"),
                silent=TRUE)
    if (is(sock, "try-error"))
      stop("Could not connect to Mongo!")
    class(sock) <- c("mongoConnection", class(sock))    

    assign("connect", sock, envir=mongoEnv)
    
    sock
  }


##' Print method for Mongo connections
##'
##' Prints stuff for mongo.
##'
##' @param a mongoConnection 

print.mongoConnection <-
  function(conn){    
    print("connected to mongo!")
  }

##' Connect method for Mongo connections
##'
##' Prints stuff for mongo.
##'
##' @param a mongoConnection 

connect.sockconn <-
  function(conn){
    pg = try(
      silent = TRUE)
    if(is(conn, "sockconn") && isOpen(conn) && pg == 1){
      conn
    }
    else{
      host.port <- strsplit(summary(a)$description, ":")[[1]]
      host <- substr(host.port[1], 3, nchar(host))
      port <- as.numeric(host.port[2])
      mongoConnect(host=host, port=port)      
    }
  }

connect <- function(x)
  UseMethod("connect")

##' ##' The internal Mongo environment
##'
##' Keeps track of active connections and cursors.
##' Not exported!

mongoEnv <- new.env()


##' Mongo Get
##'
##' getting stuff from the mongo
##'
##' @export
##' @param name

monGet <- function(nam){
  get(nam, envir=mongoEnv)
}

