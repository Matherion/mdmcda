% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/build_weighed_estimate_df.R
\name{build_weighed_estimate_df}
\alias{build_weighed_estimate_df}
\title{Build a dataframe for weighed estimates}
\usage{
build_weighed_estimate_df(
  multiEstimateDf,
  criterionOrder,
  scorer,
  decisionOrder = NULL,
  scenarioOrder = NULL,
  scenarioDefinitions = NULL,
  setMissingEstimates = NULL,
  warnForMissingEstimates = TRUE,
  warnForDuplicateEstimates = TRUE
)
}
\arguments{
\item{multiEstimateDf}{A multi estimate data frame that should contain
columns `decision_id`, `decision_label`, `alternative_value`,
`alternative_label`, `criterion_id`, `criterion_label`, and
one or more estimates in columns named with the scorer identifiers. Columns
with the `_id` suffix contain identifiers, and columns with the `_label`
suffix contain human-readable labels. This dataframe is stored in the
object called `multiEstimateDf` returned by a call to
[read_performance_tables()] to read a set of scored performance tables. Note
that different column names can be set using [mdmcda::opts].}

\item{criterionOrder}{A vector with the identifiers of the criteria
to process.}

\item{scorer}{The name of the scorer whose estimates to process.}

\item{decisionOrder}{A vector with the identifiers of the decisions
to process.}

\item{scenarioOrder}{A vector with the identifiers of the scenarios to
process.}

\item{scenarioDefinitions}{A named list of named vectors. Every named vector
contains the selected alternative from each decision (with the decision's
identifier being each elements name), and every vectors name is the
identifier of the scenario it defines.}

\item{setMissingEstimates}{The value to set for missing estimates.}

\item{warnForMissingEstimates}{Whether to warn when missing estimates are
envountered (and replaced by `setMissingEstimates`).}

\item{warnForDuplicateEstimates}{Whether to warn when duplicate estimates are
encountered. If multiple estimates _are_ encountered, the mean is taken.}
}
\value{
A dataframe with columns `scenario_id`, `decision_id`,
`alternative_value`, `criterion_id`, and `estimate`. This data frame can
be supplied to [weigh_estimates_by_profile()].
}
\description{
This function is used to produce a data frame that can then be filled with
weighed estimates using [weigh_estimates_by_profile()].
}
