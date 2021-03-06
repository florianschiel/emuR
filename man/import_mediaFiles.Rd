% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/database.files.R
\name{import_mediaFiles}
\alias{import_mediaFiles}
\title{Import media files to emuDB}
\usage{
import_mediaFiles(dbName, dir, targetSessionName = "0000", dbUUID = NULL,
  verbose = TRUE)
}
\arguments{
\item{dbName}{name of emuDB}

\item{dir}{directory containing mediafiles or session directories}

\item{targetSessionName}{name of session in which to create the new bundles}

\item{dbUUID}{optional UUID of emuDB}

\item{verbose}{display infos & show progress bar}
}
\description{
Import media files to emuDB
}
\examples{
\dontrun{
## Add mediafiles from directory

 import_mediaFiles('myEmuDB',dir="/data/mymedia/")

}
}
\author{
Klaus Jaensch
}
\keyword{Emu}
\keyword{database}
\keyword{emuDB}

