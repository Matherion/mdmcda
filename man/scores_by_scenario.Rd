% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scores_by_scenario.R
\name{scores_by_scenario}
\alias{scores_by_scenario}
\title{Get the aggregated scores for each scenario}
\usage{
scores_by_scenario(weighedEstimates, estimateCols, fun = sum, ...)
}
\arguments{
\item{weighedEstimates}{The `weighedEstimates` object as created by
[mdmcda::build_weighed_estimate_df()] and filled with the desired
weighed estimates by [mdmcda::weigh_estimates_by_profile()].}

\item{estimateCols}{The column name(s) of the estimates to aggregate using
function `fun`}

\item{fun}{The function to use for the aggregation.}

\item{...}{Additional arguments are passed to `fun`.}
}
\value{
A data frame with the scenario identifiers and the aggregated
scores.
}
\description{
Get the aggregated scores for each scenario
}
