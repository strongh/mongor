\name{mongoResp}
\alias{mongoResp}
\title{Eagerly await mongo's reponse...}
\usage{mongoResp(conn, timeout=10)}
\description{Eagerly await mongo's reponse}
\details{Polls the socket connection for non-null value.
Assume that the first 4 bytes are a int32 describing the message length.
Attempt to read the message length.}
\arguments{\item{connection}{an open socket}
\item{timeout}{how many tries to get a non-null}}
