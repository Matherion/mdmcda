% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_estimates_from_xl.R
\name{read_estimates_from_xl}
\alias{read_estimates_from_xl}
\title{Load estimates from an Excel file}
\usage{
read_estimates_from_xl(file, multiEstimateDf = TRUE)
}
\arguments{
\item{file}{The filename.}

\item{multiEstimateDf}{Whether the file contains an exported
`multiEstimateDf`.}
}
\value{
The object with the estimates, containing the spreadsheet in
`$multiEstimateDf`.
}
\description{
This function loads estimates that have been exported
from an Excel file. For loading estimates from
completed performance tables, use [mdmcda::read_performance_tables()].
}
