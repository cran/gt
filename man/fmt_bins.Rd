% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format_data.R
\name{fmt_bins}
\alias{fmt_bins}
\title{Format column data containing bin/interval information}
\usage{
fmt_bins(
  data,
  columns = everything(),
  rows = everything(),
  sep = "--",
  fmt = NULL
)
}
\arguments{
\item{data}{\emph{The gt table data object}

\verb{obj:<gt_tbl>} // \strong{required}

This is the \strong{gt} table object that is commonly created through use of the
\code{\link[=gt]{gt()}} function.}

\item{columns}{\emph{Columns to target}

\code{\link[=rows-columns]{<column-targeting expression>}} // \emph{default:} \code{everything()}

Can either be a series of column names provided in \code{c()}, a vector of
column indices, or a select helper function (e.g. \code{\link[=starts_with]{starts_with()}},
\code{\link[=ends_with]{ends_with()}}, \code{\link[=contains]{contains()}}, \code{\link[=matches]{matches()}}, \code{\link[=num_range]{num_range()}} and \code{\link[=everything]{everything()}}).}

\item{rows}{\emph{Rows to target}

\code{\link[=rows-columns]{<row-targeting expression>}} // \emph{default:} \code{everything()}

In conjunction with \code{columns}, we can specify which of their rows should
undergo formatting. The default \code{\link[=everything]{everything()}} results in all rows in
\code{columns} being formatted. Alternatively, we can supply a vector of row
captions within \code{c()}, a vector of row indices, or a select helper
function (e.g. \code{\link[=starts_with]{starts_with()}}, \code{\link[=ends_with]{ends_with()}}, \code{\link[=contains]{contains()}}, \code{\link[=matches]{matches()}},
\code{\link[=num_range]{num_range()}}, and \code{\link[=everything]{everything()}}). We can also use expressions to filter
down to the rows we need (e.g., \verb{[colname_1] > 100 & [colname_2] < 50}).}

\item{sep}{\emph{Separator between values}

\verb{scalar<character>} // \emph{default:} \code{"--"}

The separator text that indicates the values are ranged. The default value
of \code{"--"} indicates that an en dash will be used for the range separator.
Using \code{"---"} will be taken to mean that an em dash should be used. Should
you want these special symbols to be taken literally, they can be supplied
within \code{\link[base:AsIs]{base::I()}}.}

\item{fmt}{\emph{Formatting expressions}

\verb{<single expression>} // \emph{default:} \code{NULL} (\code{optional})

An optional formatting expression in formula form. If used, the RHS of \code{~}
should contain a formatting call (e.g.,
\verb{~ fmt_number(., decimals = 3, use_seps = FALSE}).}
}
\value{
An object of class \code{gt_tbl}.
}
\description{
When using \code{cut()} (or other functions that use it in some way)
you get bins that can look like this: \code{"(0,10]"}, \code{"(10,15]"}, \code{"(15,20]"},
\code{"(20,40]"}. This interval notation expresses the lower and upper limits of
each range. The square or round brackets define whether each of the endpoints
are included in the range (\code{[}/\verb{]} for inclusion, \code{(}/\verb{)} for exclusion).
Should bins of this sort be present in a table, the \code{fmt_bins()} function can
be used to format that syntax to a form that presents better in a display
table. It's possible to format the values of the intervals with the \code{fmt}
argument, and, the separator can be modified with the \code{sep} argument.
}
\section{Compatibility of formatting function with data values}{


\code{fmt_bins()} is compatible with body cells that are  of the \code{"character"} or
\code{"factor"} types. Any other types of body cells are ignored during formatting.
This is to say that cells of incompatible data types may be targeted, but
there will be no attempt to format them.
}

\section{Formatting expressions for \code{fmt}}{


We can supply a one-sided (RHS only) expression to \code{fmt}, and, several can be
provided in a list. The expression uses a formatting function (e.g.,
\code{\link[=fmt_number]{fmt_number()}}, \code{\link[=fmt_currency]{fmt_currency()}}, etc.) and it must contain an initial \code{.}
that stands for the data object. If performing numeric formatting it might
look something like this:

\code{fmt = ~ fmt_number(., decimals = 1, use_seps = FALSE)}
}

\section{Examples}{


Use the \code{\link{countrypops}} dataset to create a \strong{gt} table. Before even getting
to the \code{\link[=gt]{gt()}} call, we use \code{cut()} in conjunction with \code{\link[scales:breaks_log]{scales::breaks_log()}}
to create some highly customized bins. Consequently each country's population
in the 2021 year is assigned to a bin. These bins have a characteristic type
of formatting that can be used as input to \code{fmt_bins()}, and using that
formatting function allows us to customize the presentation of those ranges.
For instance, here we are formatting the left and right values of the ranges
with \code{\link[=fmt_integer]{fmt_integer()}} (using formula syntax).

\if{html}{\out{<div class="sourceCode r">}}\preformatted{countrypops |>
  dplyr::filter(year == 2021) |>
  dplyr::select(country_code_2, population) |>
  dplyr::mutate(population_class = cut(
    population,
    breaks = scales::breaks_log(n = 20)(population)
    )
  ) |>
  dplyr::group_by(population_class) |>
  dplyr::summarize(
    count = dplyr::n(),
    countries = paste0(country_code_2, collapse = ",")
  ) |>
  dplyr::arrange(desc(population_class)) |>
  gt() |>
  fmt_flag(columns = countries) |>
  fmt_bins(
    columns = population_class,
    fmt = ~ fmt_integer(., suffixing = TRUE)
  ) |>
  cols_label(
    population_class = "Population Range",
    count = "",
    countries = "Countries"
  ) |>
  cols_width(
    population_class ~ px(150),
    count ~ px(50)
  ) |>
  tab_style(
    style = cell_text(style = "italic"),
    locations = cells_body(columns = count)
  )
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_fmt_bins_1.png" alt="This image of a table was generated from the first code example in the `fmt_bins()` help file." style="width:100\%;">
}}
}

\section{Function ID}{

3-17
}

\section{Function Introduced}{

\code{v0.9.0} (Mar 31, 2023)
}

\seealso{
Other data formatting functions: 
\code{\link{data_color}()},
\code{\link{fmt}()},
\code{\link{fmt_auto}()},
\code{\link{fmt_bytes}()},
\code{\link{fmt_chem}()},
\code{\link{fmt_country}()},
\code{\link{fmt_currency}()},
\code{\link{fmt_date}()},
\code{\link{fmt_datetime}()},
\code{\link{fmt_duration}()},
\code{\link{fmt_email}()},
\code{\link{fmt_engineering}()},
\code{\link{fmt_flag}()},
\code{\link{fmt_fraction}()},
\code{\link{fmt_icon}()},
\code{\link{fmt_image}()},
\code{\link{fmt_index}()},
\code{\link{fmt_integer}()},
\code{\link{fmt_markdown}()},
\code{\link{fmt_number}()},
\code{\link{fmt_partsper}()},
\code{\link{fmt_passthrough}()},
\code{\link{fmt_percent}()},
\code{\link{fmt_roman}()},
\code{\link{fmt_scientific}()},
\code{\link{fmt_spelled_num}()},
\code{\link{fmt_tf}()},
\code{\link{fmt_time}()},
\code{\link{fmt_units}()},
\code{\link{fmt_url}()},
\code{\link{sub_large_vals}()},
\code{\link{sub_missing}()},
\code{\link{sub_small_vals}()},
\code{\link{sub_values}()},
\code{\link{sub_zero}()}
}
\concept{data formatting functions}
