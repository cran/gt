#------------------------------------------------------------------------------#
#
#                /$$
#               | $$
#     /$$$$$$  /$$$$$$
#    /$$__  $$|_  $$_/
#   | $$  \ $$  | $$
#   | $$  | $$  | $$ /$$
#   |  $$$$$$$  |  $$$$/
#    \____  $$   \___/
#    /$$  \ $$
#   |  $$$$$$/
#    \______/
#
#  This file is part of the 'rstudio/gt' project.
#
#  Copyright (c) 2018-2024 gt authors
#
#  For full copyright and license information, please look at
#  https://gt.rstudio.com/LICENSE.html
#
#------------------------------------------------------------------------------#


# Render a `units_definition` object to an HTML string
render_units <- function(units_object, context = "html") {

  for (i in seq_along(units_object)) {

    units_str_i <- ""

    units_object_i <- units_object[[i]]
    unit <- units_object_i[["unit"]]
    unit_subscript <- units_object_i[["unit_subscript"]]
    exponent <- units_object_i[["exponent"]]
    sub_super_overstrike <- units_object_i[["sub_super_overstrike"]]
    chemical_formula <- units_object_i[["chemical_formula"]]

    if (context == "latex") {
      unit <- escape_latex(unit)
      unit_subscript <- escape_latex(unit_subscript)
      exponent <- escape_latex(exponent)
    }

    if (
      context %in% c("html", "latex") &&
      grepl("x10", unit) &&
      !chemical_formula
    ) {
      unit <- gsub("x", "&times;", unit)
    }

    unit <- units_symbol_replacements(text = unit, context = context)

    # Process Markdown for different components
    if (!is.na(unit) && nchar(unit) > 2 && grepl("*", unit)) {

      if (context == "html") {
        unit <- commonmark::markdown_html(text = unit)
        unit <- gsub("^<p>|</p>\n$", "", unit)
      } else if (context == "latex") {
        unit <- commonmark::markdown_latex(text = unit)
        unit <- gsub("\n$", "", unit)
      } else if (context == "rtf") {
        unit <- markdown_to_rtf(text = unit)
      }
    }

    if (!is.na(unit_subscript) && nchar(unit_subscript) > 2 && grepl("*", unit_subscript)) {

      unit_subscript <- units_symbol_replacements(text = unit_subscript, context = context)

      if (context == "html") {
        unit_subscript <- commonmark::markdown_html(text = unit_subscript)
        unit_subscript <- gsub("^<p>|</p>\n$", "", unit_subscript)
      } else if (context == "latex") {
        unit_subscript <- commonmark::markdown_latex(text = unit_subscript)
        unit_subscript <- gsub("\n$", "", unit_subscript)
      } else if (context == "rtf") {
        unit_subscript <- markdown_to_rtf(text = unit_subscript)
      }
    }

    if (!is.na(exponent) && nchar(exponent) > 2 && grepl("*", exponent)) {

      exponent <- units_symbol_replacements(text = exponent, context = context)

      if (context == "html") {
        exponent <- commonmark::markdown_html(text = exponent)
        exponent <- gsub("^<p>|</p>\n$", "", exponent)
      } else if (context == "latex") {
        exponent <- commonmark::markdown_latex(text = exponent)
        exponent <- gsub("\n$", "", exponent)
      } else if (context == "rtf") {
        exponent <- markdown_to_rtf(text = exponent)
      }
    }

    units_str_i <- paste0(units_str_i, unit)

    # Overstriking of subscripts and superscripts is only possible
    # for the `"html"` context; deactivate this for any other context
    if (sub_super_overstrike && context != "html") {
      sub_super_overstrike <- FALSE
    }

    if (
      sub_super_overstrike &&
      !is.na(unit_subscript) &&
      !is.na(exponent)
    ) {

      if (context == "html") {
        exponent <- gsub("-", "&minus;", exponent)
      } else if (context == "latex") {
        exponent <- gsub("-", "--", exponent)
      }

      units_str_i <-
        paste0(
          units_str_i,
          units_html_sub_super(
            content_sub = unit_subscript,
            content_sup = exponent
          )
        )

    } else if (chemical_formula) {

      if (context == "html") {

        units_str_i <-
          gsub(
            "(\\d+)",
            "<span style=\"white-space:nowrap;\"><sub>\\1</sub></span>",
            units_str_i
          )

      } else if (context == "latex") {
        units_str_i <- gsub("(\\d+)", "\\\\textsubscript\\{\\1\\}", units_str_i)
      }

    } else {

      if (!is.na(unit_subscript)) {

        unit_subscript <-
          units_to_subscript(content = unit_subscript, context = context)

        units_str_i <- paste0(units_str_i, unit_subscript)
      }

      if (!is.na(exponent)) {

        if (context == "html") {
          exponent <- gsub("-", "&minus;", exponent)
        } else if (context == "latex") {
          exponent <- gsub("-", "--", exponent)
        }

        exponent <- units_to_superscript(content = exponent, context = context)

        units_str_i <- paste0(units_str_i, exponent)
      }
    }

    units_object[[i]][["built"]] <- units_str_i
  }

  units_str <- ""

  for (i in seq_along(units_object)) {

    unit_add <- units_object[[i]][["built"]]

    if (grepl("\\($|\\[$", units_str) || grepl("^\\)|^\\]", unit_add)) {
      spacer <- ""
    } else {
      spacer <- " "
    }

    # Treat special case where two simple units on both sides of a solidus
    # should have no extra spacing (e.g., 'm / s' -> 'm/s')
    if (length(units_object) == 3 && units_object[[2]][["unit"]] == "/") {
      spacer <- ""
    }

    units_str <- paste0(units_str, spacer, unit_add)
  }

  units_str <- gsub("^\\s+|\\s+$", "", units_str)

  units_str
}

units_to_superscript <- function(content, context = "html") {

  if (context == "html") {

    out <-
      paste0(
        "<span style=\"white-space:nowrap;\">",
        "<sup>", content, "</sup>",
        "</span>"
      )
  }

  if (context == "latex") {
    out <- paste0("\\textsuperscript{", content, "}")
  }

  if (context == "rtf") {
    out <- paste0("\\super ", content, " \\nosupersub")
  }

  if (context == "word") {

    out <-
      as.character(
        xml_r(
          xml_rPr(
            xml_baseline_adj(
              v_align = "superscript"
            )
          ),
          xml_t(content)
        )
      )
  }

  out
}

units_to_subscript <- function(content, context = "html") {

  if (context == "html") {

    out <-
      paste0(
        "<span style=\"white-space:nowrap;\">",
        "<sub>", content, "</sub>",
        "</span>"
      )
  }

  if (context == "latex") {
    out <- paste0("\\textsubscript{", content, "}")
  }

  if (context == "rtf") {
    out <- paste0("\\sub ", content, " \\nosupersub")
  }

  if (context == "word") {

    out <-
      as.character(
        xml_r(
          xml_rPr(
            xml_baseline_adj(
              v_align = "subscript"
            )
          ),
          xml_t(content)
        )
      )
  }

  out
}

units_html_sub_super <- function(content_sub, content_sup) {

  paste0(
    "<span style=\"",
    "display:inline-block;",
    "line-height:1em;",
    "text-align:left;",
    "font-size:60%;",
    "vertical-align:-0.25em;",
    "margin-left:0.1em;",
    "\">",
    content_sup,
    "<br>",
    content_sub,
    "</span>"
  )
}

units_symbol_replacements <- function(
    text,
    context = "html"
) {

  if (context == "html") {
    text <- replace_units_symbol(text, "^-", "^-", "&minus;")
  }

  if (context == "latex") {
    text <- replace_units_symbol(text, "^-", "^-", "--")
  }

  if (context %in% c("html", "rtf", "latex")) {

    text <- replace_units_symbol(text, "^um$", "um", "&micro;m")
    text <- replace_units_symbol(text, "^uL$", "uL", "&micro;L")
    text <- replace_units_symbol(text, "^umol", "^umol", "&micro;mol")
    text <- replace_units_symbol(text, "^ug$", "ug", "&micro;g")
    text <- replace_units_symbol(text, ":micro:", ":micro:", "&micro;")
    text <- replace_units_symbol(text, ":mu:", ":mu:", "&micro;")
    text <- replace_units_symbol(text, "^ohm$", "ohm", "&#8486;")
    text <- replace_units_symbol(text, ":ohm:", ":ohm:", "&#8486;")
    text <- replace_units_symbol(text, ":angstrom:", ":angstrom:", "&#8491;")
    text <- replace_units_symbol(text, ":times:", ":times:", "&times;")
    text <- replace_units_symbol(text, ":plusminus:", ":plusminus:", "&plusmn;")
    text <- replace_units_symbol(text, ":permil:", ":permil:", "&permil;")
    text <- replace_units_symbol(text, ":permille:", ":permille:", "&permil;")
    text <- replace_units_symbol(text, ":degree:", ":degree:", "&deg;")
    text <- replace_units_symbol(text, ":degrees:", ":degrees:", "&deg;")
    text <- replace_units_symbol(text, "degC", "degC", "&deg;C")
    text <- replace_units_symbol(text, "degF", "degF", "&deg;F")
    text <- replace_units_symbol(text, ":space:", ":space:", "&nbsp;")
    text <- replace_units_symbol(text, ":Alpha:", ":Alpha:", "&Alpha;")
    text <- replace_units_symbol(text, ":alpha:", ":alpha:", "&alpha;")
    text <- replace_units_symbol(text, ":Beta:", ":Beta:", "&Beta;")
    text <- replace_units_symbol(text, ":beta:", ":beta:", "&beta;")
    text <- replace_units_symbol(text, ":Gamma:", ":Gamma:", "&Gamma;")
    text <- replace_units_symbol(text, ":gamma:", ":gamma:", "&gamma;")
    text <- replace_units_symbol(text, ":Delta:", ":Delta:", "&Delta;")
    text <- replace_units_symbol(text, ":delta:", ":delta:", "&delta;")
    text <- replace_units_symbol(text, ":Epsilon:", ":Epsilon:", "&Epsilon;")
    text <- replace_units_symbol(text, ":epsilon:", ":epsilon:", "&epsilon;")
    text <- replace_units_symbol(text, ":Zeta:", ":Zeta:", "&Zeta;")
    text <- replace_units_symbol(text, ":zeta:", ":zeta:", "&zeta;")
    text <- replace_units_symbol(text, ":Eta:", ":Eta:", "&Eta;")
    text <- replace_units_symbol(text, ":eta:", ":eta:", "&eta;")
    text <- replace_units_symbol(text, ":Theta:", ":Theta:", "&Theta;")
    text <- replace_units_symbol(text, ":theta:", ":theta:", "&theta;")
    text <- replace_units_symbol(text, ":Iota:", ":Iota:", "&Iota;")
    text <- replace_units_symbol(text, ":iota:", ":iota:", "&iota;")
    text <- replace_units_symbol(text, ":Kappa:", ":Kappa:", "&Kappa;")
    text <- replace_units_symbol(text, ":kappa:", ":kappa:", "&kappa;")
    text <- replace_units_symbol(text, ":Lambda:", ":Lambda:", "&Lambda;")
    text <- replace_units_symbol(text, ":lambda:", ":lambda:", "&lambda;")
    text <- replace_units_symbol(text, ":Mu:", ":Mu:", "&Mu;")
    text <- replace_units_symbol(text, ":mu:", ":mu:", "&mu;")
    text <- replace_units_symbol(text, ":Nu:", ":Nu:", "&Nu;")
    text <- replace_units_symbol(text, ":nu:", ":nu:", "&nu;")
    text <- replace_units_symbol(text, ":Xi:", ":Xi:", "&Xi;")
    text <- replace_units_symbol(text, ":xi:", ":xi:", "&xi;")
    text <- replace_units_symbol(text, ":Omicron:", ":Omicron:", "&Omicron;")
    text <- replace_units_symbol(text, ":omicron:", ":omicron:", "&omicron;")
    text <- replace_units_symbol(text, ":Pi:", ":Pi:", "&Pi;")
    text <- replace_units_symbol(text, ":pi:", ":pi:", "&pi;")
    text <- replace_units_symbol(text, ":Rho:", ":Rho:", "&Rho;")
    text <- replace_units_symbol(text, ":rho:", ":rho:", "&rho;")
    text <- replace_units_symbol(text, ":Sigma:", ":Sigma:", "&Sigma;")
    text <- replace_units_symbol(text, ":sigma:", ":sigma:", "&sigma;")
    text <- replace_units_symbol(text, ":sigmaf:", ":sigmaf:", "&sigmaf;")
    text <- replace_units_symbol(text, ":Tau:", ":Tau:", "&Tau;")
    text <- replace_units_symbol(text, ":tau:", ":tau:", "&tau;")
    text <- replace_units_symbol(text, ":Upsilon:", ":Upsilon:", "&Upsilon;")
    text <- replace_units_symbol(text, ":upsilon:", ":upsilon:", "&upsilon;")
    text <- replace_units_symbol(text, ":Phi:", ":Phi:", "&Phi;")
    text <- replace_units_symbol(text, ":phi:", ":phi:", "&phi;")
    text <- replace_units_symbol(text, ":Chi:", ":Chi:", "&Chi;")
    text <- replace_units_symbol(text, ":chi:", ":chi:", "&chi;")
    text <- replace_units_symbol(text, ":Psi:", ":Psi:", "&Psi;")
    text <- replace_units_symbol(text, ":psi:", ":psi:", "&psi;")
    text <- replace_units_symbol(text, ":Omega:", ":Omega:", "&Omega;")
    text <- replace_units_symbol(text, ":omega:", ":omega:", "&omega;")
  }

  if (context == "word") {

    text <- replace_units_symbol(text, "^um$", "um", paste0("\U003BC", "m"))
    text <- replace_units_symbol(text, "^uL$", "uL", paste0("\U003BC", "L"))
    text <- replace_units_symbol(text, "^umol", "^umol", paste0("\U003BC", "mol"))
    text <- replace_units_symbol(text, "^ug$", "ug", paste0("\U003BC", "g"))
    text <- replace_units_symbol(text, ":micro:", ":micro:", "\U003BC")
    text <- replace_units_symbol(text, ":mu:", ":mu:", "\U003BC")
    text <- replace_units_symbol(text, "^ohm$", "ohm", "\U02126")
    text <- replace_units_symbol(text, ":ohm:", ":ohm:", "\U02126")
    text <- replace_units_symbol(text, ":times:", ":times:", "\U000D7")
    text <- replace_units_symbol(text, ":plusminus:", ":plusminus:", "\U000B1")
    text <- replace_units_symbol(text, ":permil:", ":permil:", "\U00089")
    text <- replace_units_symbol(text, ":permille:", ":permille:", "\U00089")
    text <- replace_units_symbol(text, ":degree:", ":degree:", "\U000B0")
    text <- replace_units_symbol(text, ":degrees:", ":degrees:", "\U000B0")
    text <- replace_units_symbol(text, "degC", "degC", paste0("\U000B0", "C"))
    text <- replace_units_symbol(text, "degF", "degF", paste0("\U000B0", "F"))
    text <- replace_units_symbol(text, ":space:", ":space:", " ")

    text <- replace_units_symbol(text, ":Alpha:", ":Alpha:", "\U0391")
    text <- replace_units_symbol(text, ":alpha:", ":alpha:", "\U03B1")
    text <- replace_units_symbol(text, ":Beta:", ":Beta:", "\U0392")
    text <- replace_units_symbol(text, ":beta:", ":beta:", "\U03B2")
    text <- replace_units_symbol(text, ":Gamma:", ":Gamma:", "\U0393")
    text <- replace_units_symbol(text, ":gamma:", ":gamma:", "\U03B3")
    text <- replace_units_symbol(text, ":Delta:", ":Delta:", "\U0394")
    text <- replace_units_symbol(text, ":delta:", ":delta:", "\U03B4")
    text <- replace_units_symbol(text, ":Epsilon:", ":Epsilon:", "\U0395")
    text <- replace_units_symbol(text, ":epsilon:", ":epsilon:", "\U03B5")
    text <- replace_units_symbol(text, ":Zeta:", ":Zeta:", "\U0396")
    text <- replace_units_symbol(text, ":zeta:", ":zeta:", "\U03B6")
    text <- replace_units_symbol(text, ":Eta:", ":Eta:", "\U0397")
    text <- replace_units_symbol(text, ":eta:", ":eta:", "\U03B7")
    text <- replace_units_symbol(text, ":Theta:", ":Theta:", "\U0398")
    text <- replace_units_symbol(text, ":theta:", ":theta:", "\U03B8")
    text <- replace_units_symbol(text, ":Iota:", ":Iota:", "\U0399")
    text <- replace_units_symbol(text, ":iota:", ":iota:", "\U03B9")
    text <- replace_units_symbol(text, ":Kappa:", ":Kappa:", "\U039A")
    text <- replace_units_symbol(text, ":kappa:", ":kappa:", "\U03BA")
    text <- replace_units_symbol(text, ":Lambda:", ":Lambda:", "\U039B")
    text <- replace_units_symbol(text, ":lambda:", ":lambda:", "\U03BB")
    text <- replace_units_symbol(text, ":Mu:", ":Mu:", "\U039C")
    text <- replace_units_symbol(text, ":mu:", ":mu:", "\U03BC")
    text <- replace_units_symbol(text, ":Nu:", ":Nu:", "\U039D")
    text <- replace_units_symbol(text, ":nu:", ":nu:", "\U03BD")
    text <- replace_units_symbol(text, ":Xi:", ":Xi:", "\U039E")
    text <- replace_units_symbol(text, ":xi:", ":xi:", "\U03BE")
    text <- replace_units_symbol(text, ":Omicron:", ":Omicron:", "\U039F")
    text <- replace_units_symbol(text, ":omicron:", ":omicron:", "\U03BF")
    text <- replace_units_symbol(text, ":Pi:", ":Pi:", "\U03A0")
    text <- replace_units_symbol(text, ":pi:", ":pi:", "\U03C0")
    text <- replace_units_symbol(text, ":Rho:", ":Rho:", "\U03A1")
    text <- replace_units_symbol(text, ":rho:", ":rho:", "\U03C1")
    text <- replace_units_symbol(text, ":Sigma:", ":Sigma:", "\U03A3")
    text <- replace_units_symbol(text, ":sigma:", ":sigma:", "\U03C3")
    text <- replace_units_symbol(text, ":sigmaf:", ":sigmaf:", "\U03C2")
    text <- replace_units_symbol(text, ":Tau:", ":Tau:", "\U03A4")
    text <- replace_units_symbol(text, ":tau:", ":tau:", "\U03C4")
    text <- replace_units_symbol(text, ":Upsilon:", ":Upsilon:", "\U03A5")
    text <- replace_units_symbol(text, ":upsilon:", ":upsilon:", "\U03C5")
    text <- replace_units_symbol(text, ":Phi:", ":Phi:", "\U03A6")
    text <- replace_units_symbol(text, ":phi:", ":phi:", "\U03C6")
    text <- replace_units_symbol(text, ":Chi:", ":Chi:", "\U03A7")
    text <- replace_units_symbol(text, ":chi:", ":chi:", "\U03C7")
    text <- replace_units_symbol(text, ":Psi:", ":Psi:", "\U03A8")
    text <- replace_units_symbol(text, ":psi:", ":psi:", "\U03C8")
    text <- replace_units_symbol(text, ":Omega:", ":Omega:", "\U03A9")
    text <- replace_units_symbol(text, ":omega:", ":omega:", "\U03C9")
  }

  text
}

replace_units_symbol <- function(text, detect, pattern, replace) {
  if (grepl(detect, text)) text <- gsub(pattern, replace, text)
  text
}
