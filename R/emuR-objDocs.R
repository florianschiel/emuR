##' Segment list
##' 
##' A segment list is the result type of legacy Emu query.
##' 
##' 
##' @aliases segmentlist emusegs
##' @format multi-columned matrix one row per segment 
##' \itemize{ 
##'   \item columnlabel 
##'   \item columnsegment onset time 
##'   \item columnsegment offset time 
##'   \item columnutterance name 
##' }
##' @seealso \code{\link{query}}, \code{\link{demo.vowels}}
##' @keywords classes
##' @name segmentlist
##' @examples
##' 
##'    data(demo.vowels)
##'    
##'    #demo.vowels is a segment list
##'    demo.vowels
##' 
NULL

##' emuR segment list
##' @description
##' A segment list is a list of segment descriptors. A segment descriptor describes a sequence of annotation elements.
##' 
##' @details
##' 
##' An emuR segment list is the default result of \code{\link{query}} and can be used to get track data using \code{\link{get_trackdata}}.
##' Inherits class \link{emusegs} and hence \code{\link{data.frame}}
##' 
##' @aliases segment list emuRsegs
##'
##' @format Attributed data.frame, one row per segment.
##' 
##' Objects of this class contain the ID's of start and end elements.
##' The segment may consist only of one single element, in this case start and end ID are equal.
##' 
##'  
##' Data frame columns are:
##' \itemize{ 
##'   \item labels: sequenced labels of segment concatenated by '->'
##'   \item start: onset time
##'   \item end: offset time 
##'   \item session: session name
##'   \item bundle: bundle name
##'   \item startItemID: item ID of first element of sequence
##'   \item endItemID: item ID of last element of sequence
##'   \item type: type of "segment" row: 'ITEM': symbolic item, 'EVENT': event item, 'SEGMENT': segment
##'
##' }
##' Additional hidden columns:
##' \itemize{
##'  \item utts utterance name (for compatibility to \link{emusegs} class)
##'  \item db_uuid UUID of emuDB
##'  \item level name of level
##'  \item sampleStart start sample
##'  \item sampleEnd end sample
##'  \item sampleRate sample rate
##' }
##' The print method of emuRsegs hides the columns listed above.
##' To print all columns of a segment list object use the print method of data.frame.
##' For example to print all columns of a emuRsegs segmentlist object \code{sl} type:
##' 
##' \code{print.data.frame(sl)}
##' 
##' Attributes:
##' \itemize{
##'   \item database: name of emuDB
##'   \item query: Query string
##'   \item type: type ('segment' or 'event') (for compatibility to \link{emusegs} class)
##' }
##' 
##'
##' 
##' @seealso \code{\link{query}},\code{\link{get_trackdata}},\link{emusegs}
##' @keywords classes
##' @name emuRsegs
##' 
NULL





##' Start and end times for EMU segment lists and trackdata objects
##' 
##' Obtain start and end times for EMU segment lists and trackdata objects
##' 
##' The function returns the start and/or end times of either a segment list or
##' a trackdata object. The former refers to the boundary times of segments,
##' the latter the start and end times at which the tracks from segments occur.
##' start.emusegs and end.emusegs give exactly the same output as start and end
##' respectively.
##' 
##' @aliases start.emusegs end.emusegs start.trackdata end.trackdata
##' @param x a segment list or a trackdata object
##' @param ...  due to the generic only
##' @return A vector of times.
##' @author Jonathan Harrington
##' @seealso \code{\link{tracktimes}}
##' @keywords utilities
##' @name start.emusegs
##' @examples
##' 
##' # start time of a segment list
##' start(polhom)
##' # duration of a segment list
##' end(polhom) - start(polhom)
##' # duration from start time of segment list
##' # and start time of parallel EPG trackdata
##' start(polhom) - start(polhom.epg)
##' 
##' 
NULL





##' Track data object
##' 
##' A track data object is the result of get_trackdata().
##' 
##' 
##' @aliases trackdata Math.trackdata Math2.trackdata Ops.trackdata
##' Summary.trackdata
##' @format \describe{ \item{\$index}{a two columned matrix, each row keeps the
##' first and last index of the \$data rows that belong to one segment}
##' \item{\$ftime}{a two columned matrix, each row keeps the times marks of one
##' segment} \item{\$data}{a multi-columned matrix with the real track values
##' for each segment} }
##' @note The entire data track is retrieved for each segment in the segment
##' list. The amount of data returned will depend on the sample rate and number
##' of columns in the track requested.
##' @section Methods: The following generic methods are implemented for
##' trackdata obects.  \describe{ \item{list("Arith")}{\code{"+"}, \code{"-"},
##' \code{"*"}, \code{"^"}, \code{"\%\%"}, \code{"\%/\%"}, \code{"/"}}
##' \item{list("Compare")}{\code{"=="}, \code{">"}, \code{"<"}, \code{"!="},
##' \code{"<="}, \code{">="}} \item{list("Logic")}{\code{"&"}, \code{"|"}.  }
##' \item{list("Ops")}{\code{"Arith"}, \code{"Compare"}, \code{"Logic"}}
##' \item{list("Math")}{\code{"abs"}, \code{"sign"}, \code{"sqrt"},
##' \code{"ceiling"}, \code{"floor"}, \code{"trunc"}, X \code{"cummax"},
##' \code{"cummin"}, \code{"cumprod"}, \code{"cumsum"}, \code{"log"},
##' \code{"log10"}, \code{"log2"}, \code{"log1p"}, \code{"acos"},
##' \code{"acosh"}, \code{"asin"}, \code{"asinh"}, \code{"atan"},
##' \code{"atanh"}, \code{"exp"}, \code{"expm1"}, \code{"cos"}, \code{"cosh"},
##' \code{"sin"}, \code{"sinh"}, \code{"tan"}, \code{"tanh"}, \code{"gamma"},
##' \code{"lgamma"}, \code{"digamma"}, \code{"trigamma"} }
##' \item{list("Math2")}{\code{"round"}, \code{"signif"}}
##' \item{list("Summary")}{\code{"max"}, \code{"min"}, \code{"range"},
##' \code{"prod"}, \code{"sum"}, \code{"any"}, \code{"all"}} }
##' @seealso \code{\link{get_trackdata}}, \code{\link{demo.vowels.fm}}
##' \code{\link{demo.all.rms}}
##' @keywords classes
##' @name trackdata
##' @examples
##' 
##'    data(demo.vowels.fm)
##'    data(demo.vowels)
##'    
##'    #Formant track data for the first segment of the segment list demo.vowels
##'    demo.vowels.fm[1]
##'   
##' 
NULL

