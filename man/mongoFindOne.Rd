\name{mongoFindOne}
\alias{mongoFindOne}
\title{Query Mongo...}
\usage{mongoFindOne(query=list(), attempts=10)}
\description{Query Mongo}
\details{Send a Mongo query object, given as an R list, and return the results.
See <URL> for complete documentation}
\value{a list of query results}
\arguments{\item{query}{a list specifiying the query}
\item{attempts}{the number of time to try reading}}
