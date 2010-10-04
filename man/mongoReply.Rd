\name{mongoReply}
\alias{mongoReply}
\title{Revieve and parse a reply...}
\usage{mongoReply(conn)}
\description{Revieve and parse a reply}
\details{Uses lower-level mongoResp to read response from the socket connection.
Strips out the header and parses the document(s).}
\value{list of objects from Mongo}
\arguments{\item{conn}{a socket connection}}
