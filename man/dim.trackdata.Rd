% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dimtrackdata.R
\name{dim.trackdata}
\alias{dim}
\alias{dim.trackdata}
\title{A method of the generic function dim for objects of class 'trackdata'}
\usage{
\method{dim}{trackdata}(x)
}
\arguments{
\item{x}{a track data object}
}
\description{
The function returns the dimension attributes of a track data object.
}
\details{
The function returns the dimension attributes of a track data object as the
number of segments x number of tracks.  c(nrow(x$index), ncol(x$data))
}
\examples{

   #isol.fdat is the formant track of the segment list isol

   #write out the dimension of the track data object 
   dim(isol.fdat)

   #because there are 13 segments
   isol.fdat$ftime

   #and there are 4 rows for each segment (see here for the first segment)
   isol.fdat$data[1,]

}
\author{
Jonathan Harrington
}
\keyword{methods}

