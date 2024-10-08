% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets.R
\docType{data}
\name{exibble}
\alias{exibble}
\title{A toy example tibble for testing with gt: exibble}
\format{
A tibble with 8 rows and 9 variables:
\describe{
\item{num}{A numeric column ordered with increasingly larger values.}
\item{char}{A character column composed of names of fruits from \code{a} to \code{h}.}
\item{fctr}{A factor column with numbers from \code{1} to \code{8}, written out.}
\item{date, time, datetime}{Character columns with dates, times, and
datetimes.}
\item{currency}{A numeric column that is useful for testing currency-based
formatting.}
\item{row}{A character column in the format \code{row_X} which can be useful for
testing with row labels in a table stub.}
\item{group}{A character column with four \code{grp_a} values and four \code{grp_b}
values which can be useful for testing tables that contain row groups.}
}
}
\usage{
exibble
}
\description{
This tibble contains data of a few different classes, which makes it
well-suited for quick experimentation with the functions in this package. It
contains only eight rows with numeric, character, and factor columns. The
last 4 rows contain \code{NA} values in the majority of this tibble's columns (1
missing value per column). The \code{date}, \code{time}, and \code{datetime} columns are
character-based dates/times in the familiar ISO 8601 format. The \code{row} and
\code{group} columns provide for unique rownames and two groups (\code{grp_a} and
\code{grp_b}) for experimenting with the \code{\link[=gt]{gt()}} function's \code{rowname_col} and
\code{groupname_col} arguments.
}
\section{Dataset ID and Badge}{

DATA-6

\if{html}{\out{
<div style="text-align:center;"><img src="https://raw.githubusercontent.com/rstudio/gt/master/images/dataset_exibble.png" alt="This image of that of a dataset badge." style="width:50\%;padding-bottom:20px;"></div>
}}
}

\section{Dataset Introduced}{

\code{v0.2.0.5} (March 31, 2020)
}

\examples{
exibble
}
\seealso{
Other datasets: 
\code{\link{constants}},
\code{\link{countrypops}},
\code{\link{films}},
\code{\link{gibraltar}},
\code{\link{gtcars}},
\code{\link{illness}},
\code{\link{metro}},
\code{\link{nuclides}},
\code{\link{peeps}},
\code{\link{photolysis}},
\code{\link{pizzaplace}},
\code{\link{reactions}},
\code{\link{rx_addv}},
\code{\link{rx_adsl}},
\code{\link{sp500}},
\code{\link{sza}},
\code{\link{towny}}
}
\concept{datasets}
\keyword{datasets}
