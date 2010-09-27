\name{make_header}
\alias{make_header}
\title{Make a message header...}
\usage{make_header(opCode, messageLength)}
\description{Make a message header}
\details{All messages to and from Mongo begin with a header of the form:

int32 - total length of the message
int32 - a request ID, which is randomly generated
int32 - the request ID of message to which this is responding (not applicable to any messages sent to mongo)
int32 - the operation code, which encodes the message type}
\value{a raw vector}
\arguments{\item{opCode}{the operation code for this message}
\item{messageLength}{the length of message (sans header), in bytes}}
