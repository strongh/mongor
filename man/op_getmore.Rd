\name{op_getmore}
\alias{op_getmore}
\title{OP_GETMORE...}
\usage{op_getmore(collection="test.$cmd", cursor.id, to_return=10)}
\description{OP_GETMORE}
\details{One of the basic mongo messages.}
\value{a raw vector encoding the query}
\arguments{\item{collection}{the name of the collection to query}
\item{query_list}{the query object, given as an R list}}
