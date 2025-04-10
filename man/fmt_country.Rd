% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format_data.R
\name{fmt_country}
\alias{fmt_country}
\title{Generate country names from their corresponding country codes}
\usage{
fmt_country(
  data,
  columns = everything(),
  rows = everything(),
  pattern = "{x}",
  sep = " ",
  locale = NULL
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

\item{pattern}{\emph{Specification of the formatting pattern}

\verb{scalar<character>} // \emph{default:} \code{"{x}"}

A formatting pattern that allows for decoration of the formatted value. The
formatted value is represented by the \code{{x}} (which can be used multiple
times, if needed) and all other characters will be interpreted as string
literals.}

\item{sep}{\emph{Separator between country names}

\verb{scalar<character>} // \emph{default:} \code{" "}

In the output of country names within a body cell, \code{sep} provides the
separator between each instance. By default, this is a single space
character (\code{" "}).}

\item{locale}{\emph{Locale identifier}

\verb{scalar<character>} // \emph{default:} \code{NULL} (\code{optional})

An optional locale identifier that can be used for formatting values
according to the locale's rules. Examples include \code{"en"} for English (United
States) and \code{"fr"} for French (France). We can call \code{\link[=info_locales]{info_locales()}} for a
useful reference for all of the locales that are supported. A locale ID can
be also set in the initial \code{\link[=gt]{gt()}} function call (where it would be used
automatically by any function with a \code{locale} argument) but a \code{locale}
value provided here will override that global locale.}
}
\value{
An object of class \code{gt_tbl}.
}
\description{
Tables that have comparable data between countries often need to have the
country name included. While this seems like a fairly simple task, being
consistent with country names is surprisingly difficult. The \code{fmt_country()}
function can help in this regard by supplying a country name based on a
2- or 3-letter ISO 3166-1 country code (e.g., Singapore has the \code{"SG"}
country code). The resulting country names have been obtained from the
Unicode \emph{CLDR} (Common Locale Data Repository), which is a good source since
all country names are agreed upon by consensus. Furthermore, the country
names can be localized through the \code{locale} argument (either in this function
or through the initial \code{\link[=gt]{gt()}} call).

Multiple country names can be included per cell by separating country codes
with commas (e.g., \code{"RO,BM"}). And it is okay if the codes are set in either
uppercase or lowercase letters. The \code{sep} argument allows for a common
separator to be applied between country names.
}
\section{Compatibility of formatting function with data values}{


\code{fmt_country()} function is compatible with body cells that are of the
\code{"character"} or \code{"factor"} types. Any other types of body cells are ignored
during formatting. This is to say that cells of incompatible data types may
be targeted, but there will be no attempt to format them.
}

\section{Compatibility of arguments with the \code{from_column()} helper function}{


\code{\link[=from_column]{from_column()}} can be used with certain arguments of \code{fmt_country()} to
obtain varying parameter values from a specified column within the table.
This means that each row could be formatted a little bit differently. These
arguments provide support for \code{\link[=from_column]{from_column()}}:
\itemize{
\item \code{pattern}
\item \code{sep}
\item \code{locale}
}

Please note that for each of the aforementioned arguments, a \code{\link[=from_column]{from_column()}}
call needs to reference a column that has data of the correct type (this is
different for each argument). Additional columns for parameter values can be
generated with \code{\link[=cols_add]{cols_add()}} (if not already present). Columns that contain
parameter data can also be hidden from final display with \code{\link[=cols_hide]{cols_hide()}}.
Finally, there is no limitation to how many arguments the \code{\link[=from_column]{from_column()}}
helper is applied so long as the arguments belong to this closed set.
}

\section{Supported regions}{


The following 242 regions (most of which comprise countries) are supported
with names across 574 locales: \code{"AD"}, \code{"AE"}, \code{"AF"}, \code{"AG"}, \code{"AI"},
\code{"AL"}, \code{"AM"}, \code{"AO"}, \code{"AR"}, \code{"AS"}, \code{"AT"}, \code{"AU"}, \code{"AW"}, \code{"AX"},
\code{"AZ"}, \code{"BA"}, \code{"BB"}, \code{"BD"}, \code{"BE"}, \code{"BF"}, \code{"BG"}, \code{"BH"}, \code{"BI"},
\code{"BJ"}, \code{"BL"}, \code{"BM"}, \code{"BN"}, \code{"BO"}, \code{"BR"}, \code{"BS"}, \code{"BT"}, \code{"BW"},
\code{"BY"}, \code{"BZ"}, \code{"CA"}, \code{"CC"}, \code{"CD"}, \code{"CF"}, \code{"CG"}, \code{"CH"}, \code{"CI"},
\code{"CK"}, \code{"CL"}, \code{"CM"}, \code{"CN"}, \code{"CO"}, \code{"CR"}, \code{"CU"}, \code{"CV"}, \code{"CW"},
\code{"CY"}, \code{"CZ"}, \code{"DE"}, \code{"DJ"}, \code{"DK"}, \code{"DM"}, \code{"DO"}, \code{"DZ"}, \code{"EC"},
\code{"EE"}, \code{"EG"}, \code{"EH"}, \code{"ER"}, \code{"ES"}, \code{"ET"}, \code{"EU"}, \code{"FI"}, \code{"FJ"},
\code{"FK"}, \code{"FM"}, \code{"FO"}, \code{"FR"}, \code{"GA"}, \code{"GB"}, \code{"GD"}, \code{"GE"}, \code{"GF"},
\code{"GG"}, \code{"GH"}, \code{"GI"}, \code{"GL"}, \code{"GM"}, \code{"GN"}, \code{"GP"}, \code{"GQ"}, \code{"GR"},
\code{"GS"}, \code{"GT"}, \code{"GU"}, \code{"GW"}, \code{"GY"}, \code{"HK"}, \code{"HN"}, \code{"HR"}, \code{"HT"},
\code{"HU"}, \code{"ID"}, \code{"IE"}, \code{"IL"}, \code{"IM"}, \code{"IN"}, \code{"IO"}, \code{"IQ"}, \code{"IR"},
\code{"IS"}, \code{"IT"}, \code{"JE"}, \code{"JM"}, \code{"JO"}, \code{"JP"}, \code{"KE"}, \code{"KG"}, \code{"KH"},
\code{"KI"}, \code{"KM"}, \code{"KN"}, \code{"KP"}, \code{"KR"}, \code{"KW"}, \code{"KY"}, \code{"KZ"}, \code{"LA"},
\code{"LB"}, \code{"LC"}, \code{"LI"}, \code{"LK"}, \code{"LR"}, \code{"LS"}, \code{"LT"}, \code{"LU"}, \code{"LV"},
\code{"LY"}, \code{"MA"}, \code{"MC"}, \code{"MD"}, \code{"ME"}, \code{"MF"}, \code{"MG"}, \code{"MH"}, \code{"MK"},
\code{"ML"}, \code{"MM"}, \code{"MN"}, \code{"MO"}, \code{"MP"}, \code{"MQ"}, \code{"MR"}, \code{"MS"}, \code{"MT"},
\code{"MU"}, \code{"MV"}, \code{"MW"}, \code{"MX"}, \code{"MY"}, \code{"MZ"}, \code{"NA"}, \code{"NC"}, \code{"NE"},
\code{"NF"}, \code{"NG"}, \code{"NI"}, \code{"NL"}, \code{"NO"}, \code{"NP"}, \code{"NR"}, \code{"NU"}, \code{"NZ"},
\code{"OM"}, \code{"PA"}, \code{"PE"}, \code{"PF"}, \code{"PG"}, \code{"PH"}, \code{"PK"}, \code{"PL"}, \code{"PM"},
\code{"PN"}, \code{"PR"}, \code{"PS"}, \code{"PT"}, \code{"PW"}, \code{"PY"}, \code{"QA"}, \code{"RE"}, \code{"RO"},
\code{"RS"}, \code{"RU"}, \code{"RW"}, \code{"SA"}, \code{"SB"}, \code{"SC"}, \code{"SD"}, \code{"SE"}, \code{"SG"},
\code{"SI"}, \code{"SK"}, \code{"SL"}, \code{"SM"}, \code{"SN"}, \code{"SO"}, \code{"SR"}, \code{"SS"}, \code{"ST"},
\code{"SV"}, \code{"SX"}, \code{"SY"}, \code{"SZ"}, \code{"TC"}, \code{"TD"}, \code{"TF"}, \code{"TG"}, \code{"TH"},
\code{"TJ"}, \code{"TK"}, \code{"TL"}, \code{"TM"}, \code{"TN"}, \code{"TO"}, \code{"TR"}, \code{"TT"}, \code{"TV"},
\code{"TW"}, \code{"TZ"}, \code{"UA"}, \code{"UG"}, \code{"US"}, \code{"UY"}, \code{"UZ"}, \code{"VA"}, \code{"VC"},
\code{"VE"}, \code{"VG"}, \code{"VI"}, \code{"VN"}, \code{"VU"}, \code{"WF"}, \code{"WS"}, \code{"YE"}, \code{"YT"},
\code{"ZA"}, \code{"ZM"}, and \code{"ZW"}.
}

\section{Examples}{


The \code{\link{peeps}} dataset will be used to generate a small \strong{gt} table
containing only the people born in the 1980s. The \code{country} column contains
3-letter country codes and those will be transformed to country names with
\code{fmt_country()}.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{peeps |>
  dplyr::filter(grepl("198", dob)) |>
  dplyr::select(name_given, name_family, country, dob) |>
  dplyr::arrange(country, name_family) |>
  gt() |>
  fmt_country(columns = country) |>
  cols_merge(columns = c(name_given, name_family)) |>
  opt_vertical_padding(scale = 0.5) |>
  tab_options(column_labels.hidden = TRUE)
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_fmt_country_1.png" alt="This image of a table was generated from the first code example in the `fmt_country()` help file." style="width:100\%;">
}}

Use the \code{\link{countrypops}} dataset to create a \strong{gt} table. We will only
include a few columns and rows from that table. The \code{country_code_3} column
has 3-letter country codes in the format required for \code{fmt_country()} and
using that function transforms the codes to country names.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{countrypops |>
  dplyr::filter(year == 2021) |>
  dplyr::filter(grepl("^S", country_name)) |>
  dplyr::arrange(country_name) |>
  dplyr::select(-country_name, -year) |>
  dplyr::slice_head(n = 10) |>
  gt() |>
  fmt_integer() |>
  fmt_flag(columns = country_code_2) |>
  fmt_country(columns = country_code_3) |>
  cols_label(
    country_code_2 = "",
    country_code_3 = "Country",
    population = "Population (2021)"
  )
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_fmt_country_2.png" alt="This image of a table was generated from the second code example in the `fmt_country()` help file." style="width:100\%;">
}}

The country names derived from country codes can be localized. Let's
translate some of those country names into three different languages using
different \code{locale} values in separate calls of \code{fmt_country()}.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{countrypops |>
  dplyr::filter(year == 2021) |>
  dplyr::arrange(desc(population)) |>
  dplyr::filter(
    dplyr::row_number() > max(dplyr::row_number()) - 5 |
    dplyr::row_number() <= 5
  ) |>
  dplyr::select(
    country_code_fl = country_code_2,
    country_code_2a = country_code_2,
    country_code_2b = country_code_2,
    country_code_2c = country_code_2,
    population
  ) |>
  gt(rowname_col = "country_code_fl") |>
  fmt_integer() |>
  fmt_flag(columns = stub()) |>
  fmt_country(columns = ends_with("a")) |>
  fmt_country(columns = ends_with("b"), locale = "ja") |>
  fmt_country(columns = ends_with("c"), locale = "ar") |>
  cols_label(
    ends_with("a") ~ "`en`",
    ends_with("b") ~ "`ja`",
    ends_with("c") ~ "`ar`",
    population = "Population",
    .fn = md
  ) |>
  tab_spanner(
    label = "Country name in specified locale",
    columns = matches("2a|2b|2c")
  ) |>
  cols_align(align = "center", columns = matches("2a|2b|2c")) |>
  opt_horizontal_padding(scale = 2)
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_fmt_country_3.png" alt="This image of a table was generated from the third code example in the `fmt_country()` help file." style="width:100\%;">
}}

Let's make another \strong{gt} table, this time using the \code{\link{films}} dataset. The
\code{countries_of_origin} column contains 2-letter country codes and some cells
contain multiple countries (separated by commas). We'll use \code{fmt_country()}
on that column and also specify that the rendered country names should be
separated by a comma and a space character. Also note that historical
country codes like \code{"SU"} ('USSR'), \code{"CS"} ('Czechoslovakia'), and \code{"YU"}
('Yugoslavia') are permitted as inputs for \code{fmt_country()}.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{films |>
  dplyr::filter(year == 1959) |>
  dplyr::select(
    contains("title"), run_time, director, countries_of_origin, imdb_url
  ) |>
  gt() |>
  tab_header(title = "Feature Films in Competition at the 1959 Festival") |>
  fmt_country(columns = countries_of_origin, sep = ", ") |>
  fmt_url(
    columns = imdb_url,
    label = fontawesome::fa("imdb", fill = "black")
  ) |>
  cols_merge(
    columns = c(title, original_title, imdb_url),
    pattern = "\{1\}<< (\{2\})>> \{3\}"
  ) |>
  cols_label(
    title = "Film",
    run_time = "Length",
    director = "Director",
    countries_of_origin = "Country"
  ) |>
  opt_vertical_padding(scale = 0.5) |>
  opt_table_font(stack = "classical-humanist", weight = "bold") |>
  opt_stylize(style = 1, color = "gray") |>
  tab_options(heading.title.font.size = px(26))
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_fmt_country_4.png" alt="This image of a table was generated from the fourth code example in the `fmt_country()` help file." style="width:100\%;">
}}

Country names can sometimes pair nicely with flag-based graphics. In this
example (using a different portion of the \code{\link{films}} dataset) we use
\code{fmt_country()} along with \code{\link[=fmt_flag]{fmt_flag()}}. The formatted country names are then
merged into the same cells as the icons via \code{\link[=cols_merge]{cols_merge()}}.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{films |>
  dplyr::filter(director == "Jean-Pierre Dardenne, Luc Dardenne") |>
  dplyr::select(title, year, run_time, countries_of_origin) |>
  gt() |>
  tab_header(title = "In Competition Films by the Dardenne Bros.") |>
  cols_add(country_flag = countries_of_origin) |>
  fmt_flag(columns = country_flag) |>
  fmt_country(columns = countries_of_origin, sep = ", ") |>
  cols_merge(
    columns = c(countries_of_origin, country_flag),
    pattern = "\{2\}<br>\{1\}"
  ) |>
  tab_style(
    style = cell_text(size = px(9)),
    locations = cells_body(columns = countries_of_origin)
  ) |>
  cols_merge(columns = c(title, year), pattern = "\{1\} (\{2\})") |>
  opt_vertical_padding(scale = 0.5) |>
  opt_horizontal_padding(scale = 3) |>
  opt_table_font(font = google_font("PT Sans")) |>
  opt_stylize(style = 1, color = "blue") |>
  tab_options(
    heading.title.font.size = px(26),
    column_labels.hidden = TRUE
  )
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_fmt_country_5.png" alt="This image of a table was generated from the fifth code example in the `fmt_country()` help file." style="width:100\%;">
}}
}

\section{Function ID}{

3-25
}

\section{Function Introduced}{

\code{v0.11.0} (July 9, 2024)
}

\seealso{
Other data formatting functions: 
\code{\link{data_color}()},
\code{\link{fmt}()},
\code{\link{fmt_auto}()},
\code{\link{fmt_bins}()},
\code{\link{fmt_bytes}()},
\code{\link{fmt_chem}()},
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
