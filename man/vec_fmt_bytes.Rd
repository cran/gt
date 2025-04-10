% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format_vec.R
\name{vec_fmt_bytes}
\alias{vec_fmt_bytes}
\title{Format a vector as values in terms of bytes}
\usage{
vec_fmt_bytes(
  x,
  standard = c("decimal", "binary"),
  decimals = 1,
  n_sigfig = NULL,
  drop_trailing_zeros = TRUE,
  drop_trailing_dec_mark = TRUE,
  use_seps = TRUE,
  pattern = "{x}",
  sep_mark = ",",
  dec_mark = ".",
  force_sign = FALSE,
  incl_space = TRUE,
  locale = NULL,
  output = c("auto", "plain", "html", "latex", "rtf", "word")
)
}
\arguments{
\item{x}{\emph{The input vector}

\code{vector(numeric|integer)} // \strong{required}

This is the input vector that will undergo transformation to a character
vector of the same length. Values within the vector will be formatted.}

\item{standard}{\emph{Standard used to express byte sizes}

\verb{singl-kw:[decimal|binary]} // \emph{default:} \code{"decimal"}

The form of expressing large byte sizes is divided between: (1) decimal
units (powers of 1000; e.g., \code{"kB"} and \code{"MB"}), and (2) binary units
(powers of 1024; e.g., \code{"KiB"} and \code{"MiB"}).}

\item{decimals}{\emph{Number of decimal places}

\code{scalar<numeric|integer>(val>=0)} // \emph{default:} \code{1}

This corresponds to the exact number of decimal places to use. A value
such as \code{2.34} can, for example, be formatted with \code{0} decimal places and
it would result in \code{"2"}. With \code{4} decimal places, the formatted value
becomes \code{"2.3400"}. The trailing zeros can be removed with
\code{drop_trailing_zeros = TRUE}.}

\item{n_sigfig}{\emph{Number of significant figures}

\code{scalar<numeric|integer>(val>=1)} // \emph{default:} \code{NULL} (\code{optional})

A option to format numbers to \emph{n} significant figures. By default, this is
\code{NULL} and thus number values will be formatted according to the number of
decimal places set via \code{decimals}. If opting to format according to the
rules of significant figures, \code{n_sigfig} must be a number greater than or
equal to \code{1}. Any values passed to the \code{decimals} and \code{drop_trailing_zeros}
arguments will be ignored.}

\item{drop_trailing_zeros}{\emph{Drop any trailing zeros}

\verb{scalar<logical>} // \emph{default:} \code{FALSE}

A logical value that allows for removal of trailing zeros (those redundant
zeros after the decimal mark).}

\item{drop_trailing_dec_mark}{\emph{Drop the trailing decimal mark}

\verb{scalar<logical>} // \emph{default:} \code{TRUE}

A logical value that determines whether decimal marks should always appear
even if there are no decimal digits to display after formatting (e.g., \code{23}
becomes \code{23.} if \code{FALSE}). By default trailing decimal marks are not shown.}

\item{use_seps}{\emph{Use digit group separators}

\verb{scalar<logical>} // \emph{default:} \code{TRUE}

An option to use digit group separators. The type of digit group separator
is set by \code{sep_mark} and overridden if a locale ID is provided to \code{locale}.
This setting is \code{TRUE} by default.}

\item{pattern}{\emph{Specification of the formatting pattern}

\verb{scalar<character>} // \emph{default:} \code{"{x}"}

A formatting pattern that allows for decoration of the formatted value. The
formatted value is represented by the \code{{x}} (which can be used multiple
times, if needed) and all other characters will be interpreted as string
literals.}

\item{sep_mark}{\emph{Separator mark for digit grouping}

\verb{scalar<character>} // \emph{default:} \code{","}

The string to use as a separator between groups of digits. For example,
using \code{sep_mark = ","} with a value of \code{1000} would result in a formatted
value of \code{"1,000"}. This argument is ignored if a \code{locale} is supplied
(i.e., is not \code{NULL}).}

\item{dec_mark}{\emph{Decimal mark}

\verb{scalar<character>} // \emph{default:} \code{"."}

The string to be used as the decimal mark. For example, using
\code{dec_mark = ","} with the value \code{0.152} would result in a formatted value
of \code{"0,152"}). This argument is ignored if a \code{locale} is supplied (i.e., is
not \code{NULL}).}

\item{force_sign}{\emph{Forcing the display of a positive sign}

\verb{scalar<logical>} // \emph{default:} \code{FALSE}

Should the positive sign be shown for positive numbers (effectively showing
a sign for all numbers except zero)? If so, use \code{TRUE} for this option. The
default is \code{FALSE}, where only negative numbers will display a minus sign.}

\item{incl_space}{\emph{Include a space between the value and the units}

\verb{scalar<logical>} // \emph{default:} \code{TRUE}

An option for whether to include a space between the value and the units.
The default is to use a space character for separation.}

\item{locale}{\emph{Locale identifier}

\verb{scalar<character>} // \emph{default:} \code{NULL} (\code{optional})

An optional locale identifier that can be used for formatting values
according to the locale's rules. Examples include \code{"en"} for English (United
States) and \code{"fr"} for French (France). We can call \code{\link[=info_locales]{info_locales()}} for a
useful reference for all of the locales that are supported.}

\item{output}{\emph{Output format}

\verb{singl-kw:[auto|plain|html|latex|rtf|word]} // \emph{default:} \code{"auto"}

The output style of the resulting character vector. This can either be
\code{"auto"} (the default), \code{"plain"}, \code{"html"}, \code{"latex"}, \code{"rtf"}, or
\code{"word"}. In \strong{knitr} rendering (i.e., Quarto or R Markdown), the \code{"auto"}
option will choose the correct \code{output} value}
}
\value{
A character vector.
}
\description{
With numeric values in a vector, we can transform each into byte values with
human readable units. \code{vec_fmt_bytes()} allows for the formatting of byte
sizes to either of two common representations: (1) with decimal units
(powers of 1000, examples being \code{"kB"} and \code{"MB"}), and (2) with binary units
(powers of 1024, examples being \code{"KiB"} and \code{"MiB"}).

It is assumed the input numeric values represent the number of bytes and
automatic truncation of values will occur. The numeric values will be scaled
to be in the range of 1 to <1000 and then decorated with the correct unit
symbol according to the standard chosen. For more control over the formatting
of byte sizes, we can use the following options:
\itemize{
\item decimals: choice of the number of decimal places, option to drop
trailing zeros, and a choice of the decimal symbol
\item digit grouping separators: options to enable/disable digit separators
and provide a choice of separator symbol
\item pattern: option to use a text pattern for decoration of the formatted
values
\item locale-based formatting: providing a locale ID will result in number
formatting specific to the chosen locale
}
}
\section{Examples}{


Let's create a numeric vector for the next few examples:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{num_vals <- c(3.24294e14, 8, 1362902, -59027, NA)
}\if{html}{\out{</div>}}

Using \code{vec_fmt_bytes()} with the default options will create a character
vector with values in bytes. Any \code{NA} values remain as \code{NA} values. The
rendering context will be autodetected unless specified in the \code{output}
argument (here, it is of the \code{"plain"} output type).

\if{html}{\out{<div class="sourceCode r">}}\preformatted{vec_fmt_bytes(num_vals)
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{#> [1] "324.3 TB" "8 B" "1.4 MB" "-59 kB" "NA"
}\if{html}{\out{</div>}}

We can change the number of decimal places with the \code{decimals} option:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{vec_fmt_bytes(num_vals, decimals = 2)
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{#> [1] "324.29 TB" "8 B" "1.36 MB" "-59.03 kB" "NA"
}\if{html}{\out{</div>}}

If we are formatting for a different locale, we could supply the locale ID
and \strong{gt} will handle any locale-specific formatting options:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{vec_fmt_bytes(num_vals, locale = "fi")
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{#> [1] "324,3 TB" "8 B" "1,4 MB" "-59 kB" "NA"
}\if{html}{\out{</div>}}

Should you need to have positive and negative signs on each of the output
values, use \code{force_sign = TRUE}:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{vec_fmt_bytes(num_vals, force_sign = TRUE)
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{#> [1] "+324.3 TB" "+8 B" "+1.4 MB" "-59 kB" "NA"
}\if{html}{\out{</div>}}

As a last example, one can wrap the values in a pattern with the \code{pattern}
argument. Note here that \code{NA} values won't have the pattern applied.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{vec_fmt_bytes(num_vals, pattern = "[\{x\}]")
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{#> [1] "[324.3 TB]" "[8 B]" "[1.4 MB]" "[-59 kB]" "NA"
}\if{html}{\out{</div>}}
}

\section{Function ID}{

15-12
}

\section{Function Introduced}{

\code{v0.7.0} (Aug 25, 2022)
}

\seealso{
The variant function intended for formatting \strong{gt} table data:
\code{\link[=fmt_bytes]{fmt_bytes()}}.

Other vector formatting functions: 
\code{\link{vec_fmt_currency}()},
\code{\link{vec_fmt_date}()},
\code{\link{vec_fmt_datetime}()},
\code{\link{vec_fmt_duration}()},
\code{\link{vec_fmt_engineering}()},
\code{\link{vec_fmt_fraction}()},
\code{\link{vec_fmt_index}()},
\code{\link{vec_fmt_integer}()},
\code{\link{vec_fmt_markdown}()},
\code{\link{vec_fmt_number}()},
\code{\link{vec_fmt_partsper}()},
\code{\link{vec_fmt_percent}()},
\code{\link{vec_fmt_roman}()},
\code{\link{vec_fmt_scientific}()},
\code{\link{vec_fmt_spelled_num}()},
\code{\link{vec_fmt_time}()}
}
\concept{vector formatting functions}
