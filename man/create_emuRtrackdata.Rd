% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/emuRtrackdata.R
\name{create_emuRtrackdata}
\alias{create_emuRtrackdata}
\title{create emuRtrackdata object}
\usage{
create_emuRtrackdata(sl, td)
}
\arguments{
\item{sl}{seglist of class emuRsegs}

\item{td}{trackdata object generated from sl}
}
\value{
emuRtrackdata object
}
\description{
Joins emuRsegs object with a trackdata object 
to create an emuRtrackdata object that basically
is a \code{\link{data.table}} (and \code{\link{data.frame}}) object.
}

