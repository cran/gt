% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers.R
\name{cells_stub_grand_summary}
\alias{cells_stub_grand_summary}
\title{Location helper for targeting the stub cells in a grand summary}
\usage{
cells_stub_grand_summary(rows = everything())
}
\arguments{
\item{rows}{\emph{Rows to target}

\verb{<row-targeting expression>} // \emph{default:} \code{everything()}

We can specify which rows should be targeted. The default \code{\link[=everything]{everything()}}
results in all rows in \code{columns} being formatted. Alternatively, we can
supply a vector of row IDs within \code{c()}, a vector of row indices, or a
select helper function (e.g. \code{\link[=starts_with]{starts_with()}}, \code{\link[=ends_with]{ends_with()}}, \code{\link[=contains]{contains()}},
\code{\link[=matches]{matches()}}, \code{\link[=num_range]{num_range()}}, and \code{\link[=everything]{everything()}}). We can also use
expressions to filter down to the rows we need
(e.g., \verb{[colname_1] > 100 & [colname_2] < 50}).}
}
\value{
A list object with the classes \code{cells_stub_grand_summary} and
\code{location_cells}.
}
\description{
\code{cells_stub_grand_summary()} is used to target the stub cells of
a grand summary and it is useful when applying a footnote with
\code{\link[=tab_footnote]{tab_footnote()}} or adding custom styles with \code{\link[=tab_style]{tab_style()}}. The function is
expressly used in each of those functions' \code{locations} argument. The
'stub_grand_summary' location is generated by \code{\link[=grand_summary_rows]{grand_summary_rows()}}.
}
\section{Targeting grand summary stub cells with \code{rows}}{


Targeting the stub cells of a grand summary row is done through the \code{rows}
argument. Grand summary cells in the stub will have ID values that can be
used much like column names in the \code{columns}-targeting scenario. We can use
simpler \strong{tidyselect}-style expressions (the select helpers should work well
here) and we can use quoted row identifiers in \code{c()}. It's also possible to
use row indices (e.g., \code{c(3, 5, 6)}) that correspond to the row number of a
grand summary row.
}

\section{Examples}{


Use a portion of the \code{\link{countrypops}} dataset to create a \strong{gt} table. Add
some styling to a grand summary stub cell with \code{\link[=tab_style]{tab_style()}} and using
\code{cells_stub_grand_summary()} in the \code{locations} argument.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{countrypops |>
  dplyr::filter(country_name == "Spain", year < 1970) |>
  dplyr::select(-contains("country")) |>
  gt(rowname_col = "year") |>
  fmt_number(
    columns = population,
    decimals = 0
  ) |>
  grand_summary_rows(
    columns = population,
    fns = list(change = ~max(.) - min(.)),
    fmt = ~ fmt_integer(.)
  ) |>
  tab_style(
    style = cell_text(weight = "bold", transform = "uppercase"),
    locations = cells_stub_grand_summary(rows = "change")
  )
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_cells_stub_grand_summary_1.png" alt="This image of a table was generated from the first code example in the `cells_stub_grand_summary()` help file." style="width:100\%;">
}}
}

\section{Function ID}{

8-22
}

\section{Function Introduced}{

\code{v0.3.0} (May 12, 2021)
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
\code{\link{cells_stub_summary}()},
\code{\link{cells_stubhead}()},
\code{\link{cells_summary}()},
\code{\link{cells_title}()},
\code{\link{location-helper}}
}
\concept{location helper functions}
