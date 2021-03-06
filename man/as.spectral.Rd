% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spectralclass.R
\name{as.spectral}
\alias{as.spectral}
\title{Function to convert an object into an object of class 'spectral'.}
\usage{
as.spectral(trackdata, fs)
}
\arguments{
\item{trackdata}{A vector, matrix, or EMU-trackdata object.}

\item{fs}{Either a single element numeric vector, or a numeric vector of
the same length as the length of trackdata if trackdata is a vector, or of
the same number of rows as trackdata}
}
\value{
The same object but of class 'spectral'.
}
\description{
The function converts a vector, matrix, or EMU-trackdata object into an
object of the same class and of class 'spectral'
}
\details{
If fs is a single element numeric vector, then the frequencies of trackdata
are defined to extend to fs/2. If fs is missing, then the frequencies are
0:(N-1) where N is the length of trackdata.
}
\examples{

vec = 1:10
as.spectral(vec, 2000)
mat = rbind(1:10, 1:10)
as.spectral(mat)
# turn a spectral trackdata object into a trackdata object
tr = as.trackdata(rbind(fric.dft$data), fric.dft$index, fric.dft$ftime)
# turn it into a spectral trackdata object with sampling freq 16 kHz
tr = as.spectral(tr, 16000)
# list the frequencies
trackfreq(tr)
# Notice that only the $data is made into a spectral matrix,
# not the entire trackdata object
# so this is trackdata
class(tr)
# this is a spectral matrix
class(tr$data)




}
\author{
Jonathan Harrington
}
\seealso{
\code{\link{is.spectral}} \code{\link{plot.spectral}}
}
\keyword{attribute}

