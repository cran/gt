% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tab_remove.R
\name{rm_spanners}
\alias{rm_spanners}
\title{Remove column spanner labels}
\usage{
rm_spanners(data, spanners = everything(), levels = NULL)
}
\arguments{
\item{data}{\emph{The gt table data object}

\verb{obj:<gt_tbl>} // \strong{required}

This is the \strong{gt} table object that is commonly created through use of the
\code{\link[=gt]{gt()}} function.}

\item{spanners}{\emph{Spanners to remove}

\verb{<spanner-targeting expression>} // \emph{default:} \code{everything()}

A specification of which spanner column labels should be removed. Those to
be removed can be given as a vector of spanner ID values (every spanner
column label has one, either set by the user or by \strong{gt} when using
\code{\link[=tab_spanner_delim]{tab_spanner_delim()}}). A select helper can also be used and, by default,
this is \code{everything()} (whereby all spanner column labels will be removed).}

\item{levels}{\emph{Spanner levels to remove}

\verb{scalar<numeric|integer>} // \emph{default:} \code{NULL} (\code{optional})

Instead of removing spanner column labels by ID values, entire levels of
spanners can instead be removed. Supply a numeric vector of level values
(the first level is \code{1}) and, if they are present, they will be removed.
Any input given to \code{level} will mean that \code{spanners} is ignored.}
}
\value{
An object of class \code{gt_tbl}.
}
\description{
If you would like to remove column spanner labels then the \code{rm_spanners()}
function can make this possible. Column spanner labels appear above the
column labels and can occupy several levels via stacking either through
\code{\link[=tab_spanner]{tab_spanner()}} or \code{\link[=tab_spanner_delim]{tab_spanner_delim()}}. Spanner column labels are
distinguishable and accessible by their ID values.

This function for removal is useful if you have received a \strong{gt} table
(perhaps through an API that returns \strong{gt} objects) but would prefer that
some or all of the column spanner labels be removed. This function is safe to
use even if there are no column spanner labels in the input \code{gt_tbl} object
so long as select helpers (such as the default \code{everything()}) are used
instead of explicit ID values.
}
\section{Examples}{


Use a portion of the \code{\link{gtcars}} dataset to create a \strong{gt} table. With
\code{\link[=tab_spanner]{tab_spanner()}}, we can group several related columns together under a
spanner column. In this example, that is done with several \code{\link[=tab_spanner]{tab_spanner()}}
calls in order to create two levels of spanner column labels.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{gt_tbl <-
  gtcars |>
  dplyr::select(
    -mfr, -trim, bdy_style, drivetrain,
    -drivetrain, -trsmn, -ctry_origin
  ) |>
  dplyr::slice(1:8) |>
  gt(rowname_col = "model") |>
  tab_spanner(label = "HP", columns = c(hp, hp_rpm)) |>
  tab_spanner(label = "Torque", columns = c(trq, trq_rpm)) |>
  tab_spanner(label = "MPG", columns = c(mpg_c, mpg_h)) |>
  tab_spanner(
    label = "Performance",
    columns = c(
      hp, hp_rpm, trq, trq_rpm,
      mpg_c, mpg_h
    )
  )

gt_tbl
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_rm_spanners_1.png" alt="This image of a table was generated from the first code example in the `rm_spanners()` help file." style="width:100\%;">
}}

If you decide that you don't want any of the spanners in the \code{gt_tbl} object,
they can all be removed with \code{rm_spanners()}.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{rm_spanners(data = gt_tbl)
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_rm_spanners_2.png" alt="This image of a table was generated from the second code example in the `rm_spanners()` help file." style="width:100\%;">
}}

Individual spanner column labels can be removed by ID value. In all the above
uses of \code{\link[=tab_spanner]{tab_spanner()}}, the \code{label} value \emph{is} the ID value (you can
alternately set a different ID value though the \code{id} argument). Let's remove
the \code{"HP"} and \code{"MPG"} spanner column labels with \code{rm_spanners()}.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{rm_spanners(data = gt_tbl, spanners = c("HP", "MPG"))
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_rm_spanners_3.png" alt="This image of a table was generated from the third code example in the `rm_spanners()` help file." style="width:100\%;">
}}

We can also remove spanner column labels by level with \code{rm_spanners()}.
Provide a vector of one or more values greater than or equal to \code{1} (the
first level starts there). In the next example, we'll remove the first level
of spanner column labels. Any levels not being removed will collapse down
accordingly.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{rm_spanners(data = gt_tbl, levels = 1)
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_rm_spanners_4.png" alt="This image of a table was generated from the fourth code example in the `rm_spanners()` help file." style="width:100\%;">
}}
}

\section{Function ID}{

7-3
}

\section{Function Introduced}{

\code{v0.8.0} (November 16, 2022)
}

\seealso{
Other part removal functions: 
\code{\link{rm_caption}()},
\code{\link{rm_footnotes}()},
\code{\link{rm_header}()},
\code{\link{rm_source_notes}()},
\code{\link{rm_stubhead}()}
}
\concept{part removal functions}
