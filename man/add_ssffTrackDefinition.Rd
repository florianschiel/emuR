% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/database.DBconfig.R
\name{add_ssffTrackDefinition}
\alias{add_ssffTrackDefinition}
\title{Add ssffTrackDefinition to emuDB}
\usage{
add_ssffTrackDefinition(dbName = NULL, name = NULL, columnName = NULL,
  fileExtension = NULL, onTheFlyFunctionName = NULL,
  onTheFlyParams = NULL, onTheFlyOptLogFilePath = NULL, dbUUID = NULL,
  showProgress = TRUE, interactive = TRUE)
}
\arguments{
\item{dbName}{name of emuDB}

\item{name}{name of ssffTrackDefinitions}

\item{columnName}{columnName of ssffTrackDefinitions.
If the \code{onTheFlyFunctionName} parameter is set and this one isn't the
\code{columnName} will default to the first entry in \code{wrasspOutputInfos[[onTheFlyFunctionName]]$tracks}.}

\item{fileExtension}{fileExtension of ssffTrackDefinitions.
If the \code{onTheFlyFunctionName} parameter is set and this one isn't the
\code{fileExtension} will default to the first entry in \code{wrasspOutputInfos[[onTheFlyFunctionName]]$ext}.}

\item{onTheFlyFunctionName}{name of wrassp function to do on-the-fly calculation}

\item{onTheFlyParams}{a list parameters that will be given to the function 
passed in by the onTheFlyFunctionName parameter. This list can easily be 
generated using the \code{formals} function and then setting the according 
parameter one wishes to change.}

\item{onTheFlyOptLogFilePath}{path to optional log file for on-the-fly function}

\item{dbUUID}{optional UUID of emuDB}

\item{showProgress}{show progress bar}

\item{interactive}{ask user for confirmation}
}
\description{
Add ssffTrackDefinitions to emuDB
}
\author{
Raphael Winkelmann
}
\seealso{
wrasspOutputInfos
}

