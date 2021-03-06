##' emuR - Main package of the EMU Speech Database Management System
##' 
##' The emuR package provides the next iteration of the EMU Speech 
##' Database Management System with database management, data 
##' extraction, data preparation and data visualization facilities. 
##' It also contains a server that 
##' is intended to host databases in the emuDB format (see \code{vignette('emuDB_intro')}) to the EMU-webApp 
##' (\url{http://ips-lmu.github.io/EMU-webApp/}). The querying of annotations is 
##' performed using EMU's own EQL2 (EMU Query Language Version 2).
##' 
##' This package is part of the next iteration of the EMU Speech Database Management System 
##' which aims to be as close to an all-in-one solution for generating, manipulating, querying, 
##' analyzing and managing speech databases as possible. 
##' For an overview of the system please visit this URL: \url{http://ips-lmu.github.io/EMU.html}.
##'  
##' Typical work-flow in emuR (emuDB required):
##' 
##' \enumerate{
##' \item Load database into current R session - \code{\link{load_emuDB}}
##' \item Database annotation / visual inspection - \code{\link{serve}} and connect the EMU-webApp to the local server
##' \item Query database - \code{\link{query}} (sometimes followed by \code{\link{requery_hier}} or \code{\link{requery_seq}})
##' \item Get trackdata (e.g. formant values) for the result of a query - \code{\link{get_trackdata}}
##' \item Data preparation - \code{\link{dcut}}, \code{\link{mel}}
##' \item Visual data inspection - \code{\link{plot}}, \code{\link{dplot}}, \code{\link{eplot}}
##' \item Further analysis and statistical processing
##' }
##' 
##' @name emuR-package
##' @aliases emuR emuR-package
##' 
##' @references Harrington, J. (2010). The Phonetic Analysis of Speech Corpora.
##' Blackwell.
##' 
##' @keywords package
##' @import methods
##' @docType package
##' @examples
##' \dontrun{
##' # create demo data including an emuDB called "ae" 
##' create_emuRdemoData()
##' 
##' # construct path to demo emuDB
##' path2ae = file.path(tempdir(), "emuR_demoData", "ae")
##' 
##' # load emuDB into current R session
##' dbName = load_emuDB(path2ae)
##' 
##' # query loaded emuDB
##' lvowels = query(dbName, "Phonetic = i: | u: | o:")
##' 
##' # extract labels from query result 
##' lvowels.labs = label(lvowels)
##' 
##' # list all ssffTrackDefinitions of emuDB
##' list_ssffTrackDefinitions(dbName)
##' 
##' # get formant trackdata defined in ssffTrackDefinitions "fm" for query result
##' lvowels.fm = get_trackdata(dbName, lvowels, "fm")
##' 
##' # extract track values at temporal midpoint of segments
##' lvowels.fmCut = dcut(lvowels.fm, .5, prop =TRUE)
##' 
##' # Plot the data as time signal and formant card
##' dplot(lvowels.fm[,1:2], lvowels.labs, normalise=TRUE, main = "Formants over vowel duration")
##' eplot(lvowels.fmCut[,1:2], lvowels.labs, dopoints=TRUE, 
##'       doellipse=FALSE, main = "F1/F2 of vowel midpoint", form=TRUE, 
##'       xlab = "F2 in Hz", ylab = "F1 in Hz")
##'       
##'       
##' # Plot of spectral data from 50% of aspiration duration
##' hs = query(dbName,"Phonetic = H")
##' hs.labs = label(hs)
##' hs.dft = get_trackdata(dbName, hs, "dft")
##' hs.dftCut = dcut(hs.dft, .5, prop=TRUE)
##' plot(hs.dftCut, hs.labs, main = "Spectral data of aspiration")
##' 
##' }
##' 
NULL



