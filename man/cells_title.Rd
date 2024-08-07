% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers.R
\name{cells_title}
\alias{cells_title}
\title{Location helper for targeting the table title and subtitle}
\usage{
cells_title(groups = c("title", "subtitle"))
}
\arguments{
\item{groups}{\emph{Specification of groups}

\verb{mult-kw:[title|subtitle]} // \emph{default:} \code{c("title", "subtitle")}

We can either specify \code{"title"}, \code{"subtitle"}, or both (the default) in a
vector to target the title element, the subtitle element, or both elements.}
}
\value{
A list object of classes \code{cells_title} and \code{location_cells}.
}
\description{
\code{cells_title()} is used to target the table title or subtitle
when applying a footnote with \code{\link[=tab_footnote]{tab_footnote()}} or adding custom style with
\code{\link[=tab_style]{tab_style()}}. The function is expressly used in each of those functions'
\code{locations} argument. The header location where the title and optionally the
subtitle reside is generated by the \code{\link[=tab_header]{tab_header()}} function.
}
\section{Examples}{


Use a subset of the \code{\link{sp500}} dataset to create a small \strong{gt} table. Add a
header with a title, and then add a footnote to the title with
\code{\link[=tab_footnote]{tab_footnote()}} and \code{cells_title()} (in \code{locations}).

\if{html}{\out{<div class="sourceCode r">}}\preformatted{sp500 |>
  dplyr::filter(date >= "2015-01-05" & date <= "2015-01-10") |>
  dplyr::select(-c(adj_close, volume, high, low)) |>
  gt() |>
  tab_header(title = "S&P 500") |>
  tab_footnote(
    footnote = "All values in USD.",
    locations = cells_title(groups = "title")
  )
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_cells_title_1.png" alt="This image of a table was generated from the first code example in the `cells_title()` help file." style="width:100\%;">
}}
}

\section{Function ID}{

8-12
}

\section{Function Introduced}{

\code{v0.2.0.5} (March 31, 2020)
}

\seealso{
Other location helper functions: 
\code{\link{cells_body}()},
\code{\link{cells_column_labels}()},
\code{\link{cells_column_spanners}()},
\code{\link{cells_footnotes}()},
\code{\link{cells_grand_summary}()},
\code{\link{cells_row_groups}()},
\code{\link{cells_source_notes}()},
\code{\link{cells_stub}()},
\code{\link{cells_stub_grand_summary}()},
\code{\link{cells_stub_summary}()},
\code{\link{cells_stubhead}()},
\code{\link{cells_summary}()},
\code{\link{location-helper}}
}
\concept{location helper functions}
