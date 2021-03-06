% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/server.R
\name{serve}
\alias{serve}
\title{Serve EMU database to EMU-webApp}
\usage{
serve(dbName, host = "127.0.0.1", port = 17890, debug = FALSE,
  debugLevel = 0)
}
\arguments{
\item{dbName}{name of a loaded EMU database}

\item{host}{host IP to listen to (default: 127.0.0.1  (localhost))}

\item{port}{the port number to listen on (default: 17890)}

\item{debug}{TRUE to enable debugging (default: no debugging messages)}

\item{debugLevel}{integer higher values generate more detailed debug output}
}
\value{
TRUE if the database was modified, FALSE otherwise
}
\description{
Server for EMU-webApp browser GUI \url{http://ips-lmu.github.io/EMU-webApp/}

Start instructions:

Call this function to start the server. Do not forget to (re-)assign the return value to reflect changes made in the Web application: \code{myDb=serve(myDb)}.

Start a suitable HTML5 capable Web-Browser (Google Chrome, Firefox,...).

Navigate to the EMU-Webapp URL: \url{http://ips-lmu.github.io/EMU-webApp/}.

Press the 'Connect' button in the EMU-webApp and connect with default URL.

EMU-webApp should load the bundle list and the first bundle of the given database (object).

Stop instructions:

Stop the server with the 'Clear' button of the webapp or the reload button of your browser.

The server can be interrupted with Ctrl-C if something wents wrong.
}
\details{
Function opens a HTTP/websocket and waits in a loop for browser requests. The R console will be blocked. On successfull connection the server sends the session and bundle list of the given database object. The Web application requests bundle data for editing. If a bundle is modified with the EMU-webApp and the save button is pressed the server modifies the database object and saves the changes to disk. Communication is defined by EMU-webApp-websocket-protocol version 0.0.2
}
\examples{
\dontrun{ 
## Load EMU database 'myDb' and serve it to the EMU-webApp (opens default HTTP/websocket port 17890)

load_emuDB("/path/to/myDb")
serve('myDb')
}

}
\author{
Klaus Jaensch
}
\keyword{EMU-webApp}
\keyword{Emu}
\keyword{database}
\keyword{emuDB}
\keyword{websocket}

