% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets.R
\docType{data}
\name{photolysis}
\alias{photolysis}
\title{Data on photolysis rates for gas-phase organic compounds}
\format{
A tibble with 34 rows and 10 variables:
\describe{
\item{compd_name}{The name of the primary compound undergoing photolysis.}
\item{cmpd_formula}{The chemical formula of the compound.}
\item{products}{A product pathway for the photolysis of the compound.}
\item{type}{The type of organic compound undergoing photolysis.}
\item{l, m, n}{The parameter values given in the \code{l}, \code{m}, and \code{n} columns
can be used to calculate the photolysis rate (\emph{J}) as a function of the
solar zenith angle (\emph{X}, in radians) through the expression:
\code{J = l * cos(X)^m * exp(-n * sec(X))}.}
\item{quantum_yield}{In the context of photolysis reactions, this is the
efficiency of a given photolytic reaction. In other words, it's the number of
product molecules formed over the number of photons absorbed.}
\item{wavelength_nm, sigma_298_cm2}{The \code{wavelength_nm} and \code{sigma_298_cm2}
columns provide photoabsorption data for the compound undergoing photolysis.
The values in \code{wavelength_nm} provide the wavelength of light in nanometer
units; the \code{sigma_298_cm2} values are paired with the \code{wavelength_nm} values
and they are in units of \verb{cm^2 molecule^-1}.}
}
}
\usage{
photolysis
}
\description{
The \code{photolysis} dataset contains numerical values for describing the
photolytic degradation pathways of 25 compounds of relevance in atmospheric
chemistry. Many volatile organic compounds (VOCs) are emitted in substantial
quantities from both biogenic and anthropogenic sources, and they can have a
major influence on the chemistry of the lower atmosphere. A portion of these
can be transformed into other VOCs via the energy provided from light.

In order to realistically predict the composition of the atmosphere and how
it evolves over time, we need accurate estimates of photolysis rates. The
data provided here in \code{photolysis} allows for computations of photolysis
rates (\emph{J}, having units of \code{s^-1}) as a function of the solar zenith angle
(SZA). Having such values is essential when deploying atmospheric chemistry
models.
}
\section{Dataset ID and Badge}{

DATA-15

\if{html}{\out{
<div style="text-align:center;"><img src="https://raw.githubusercontent.com/rstudio/gt/master/images/dataset_photolysis.png" alt="This image of that of a dataset badge." style="width:50\%;padding-bottom:20px;"></div>
}}
}

\section{Dataset Introduced}{

\code{v0.11.0} (July 9, 2024)
}

\examples{
dplyr::glimpse(photolysis)
}
\seealso{
Other datasets: 
\code{\link{constants}},
\code{\link{countrypops}},
\code{\link{exibble}},
\code{\link{films}},
\code{\link{gibraltar}},
\code{\link{gtcars}},
\code{\link{illness}},
\code{\link{metro}},
\code{\link{nuclides}},
\code{\link{peeps}},
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
