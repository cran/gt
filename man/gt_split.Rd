% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gt_split.R
\name{gt_split}
\alias{gt_split}
\title{Split a table into a group of tables (a \code{gt_group})}
\usage{
gt_split(data, row_every_n = NULL, row_slice_i = NULL, col_slice_at = NULL)
}
\arguments{
\item{data}{\emph{The gt table data object}

\verb{obj:<gt_tbl>} // \strong{required}

This is the \strong{gt} table object that is commonly created through use of the
\code{\link[=gt]{gt()}} function.}

\item{row_every_n}{\emph{Split at every n rows}

\verb{scalar<numeric|integer>} // \emph{default:} \code{NULL} (\code{optional})

A directive to split at every \emph{n} number of rows. This argument expects a
single numerical value.}

\item{row_slice_i}{\emph{Row-slicing indices}

\verb{vector<numeric|integer>} // \emph{default:} \code{NULL} (\code{optional})

An argument for splitting at specific row indices. Here, we expect either a
vector of index values or a function that evaluates to a numeric vector.}

\item{col_slice_at}{\emph{Column-slicing locations}

\verb{<column-targeting expression>} // \emph{default:} \code{NULL} (\code{optional})

Any columns where vertical splitting across should occur. The splits occur
to the right of the resolved column names. Can either be a series of column
names provided in \code{c()}, a vector of column indices, or a select helper
function (e.g. \code{\link[=starts_with]{starts_with()}}, \code{\link[=ends_with]{ends_with()}}, \code{\link[=contains]{contains()}}, \code{\link[=matches]{matches()}},
\code{\link[=num_range]{num_range()}}, and \code{\link[=everything]{everything()}}).}
}
\value{
An object of class \code{gt_group}.
}
\description{
With a \strong{gt} table, you can split it into multiple tables and get that
collection in a \code{gt_group} object. This function is useful for those cases
where you want to section up a table in a specific way and print those
smaller tables across multiple pages (in RTF and Word outputs, primarily via
\code{\link[=gtsave]{gtsave()}}), or, with breaks between them when the output context is HTML.
}
\section{Examples}{


Use a subset of the \code{\link{gtcars}} dataset to create a \strong{gt} table. Format the
\code{msrp} column to display numbers as currency values, set column widths with
\code{\link[=cols_width]{cols_width()}}, and split the table at every five rows with \code{gt_split()}.
This creates a \code{gt_group} object containing two tables. Printing this object
yields two tables separated by a line break.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{gtcars |>
  dplyr::slice_head(n = 10) |>
  dplyr::select(mfr, model, year, msrp) |>
  gt() |>
  fmt_currency(columns = msrp) |>
  cols_width(
    year ~ px(80),
    everything() ~ px(150)
  ) |>
  gt_split(row_every_n = 5)
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_gt_split_1.png" alt="This image of a table was generated from the first code example in the `gt_split()` help file." style="width:100\%;">
}}

Use a smaller subset of the \code{\link{gtcars}} dataset to create a \strong{gt} table.
Format the \code{msrp} column to display numbers as currency values, set the table
width with \code{\link[=tab_options]{tab_options()}} and split the table at the \code{model} column This
creates a \code{gt_group} object again containing two tables but this time we get
a vertical split. Printing this object yields two tables of the same width.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{gtcars |>
  dplyr::slice_head(n = 5) |>
  dplyr::select(mfr, model, year, msrp) |>
  gt() |>
  fmt_currency(columns = msrp) |>
  tab_options(table.width = px(400)) |>
  gt_split(col_slice_at = "model")
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_gt_split_2.png" alt="This image of a table was generated from the second code example in the `gt_split()` help file." style="width:100\%;">
}}
}

\section{Function ID}{

14-2
}

\section{Function Introduced}{

\code{v0.9.0} (Mar 31, 2023)
}

\seealso{
Other table group functions: 
\code{\link{grp_add}()},
\code{\link{grp_clone}()},
\code{\link{grp_options}()},
\code{\link{grp_pull}()},
\code{\link{grp_replace}()},
\code{\link{grp_rm}()},
\code{\link{gt_group}()}
}
\concept{table group functions}
