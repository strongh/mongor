\name{op_query}
\alias{op_query}
\title{OP_QUERY...}
\usage{op_query(collection="test.$cmd", query_list=list())}
\description{OP_QUERY}
\details{One of the basic mongo messages.}
\value{a raw vector encoding the query}
\arguments{\item{collection}{the name of the collection to query}
\item{query_list}{the query object, given as an R list}}
