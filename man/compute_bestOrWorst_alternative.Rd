% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compute_best_alternatives.R,
%   R/compute_worst_alternatives.R
\name{compute_best_alternatives}
\alias{compute_best_alternatives}
\alias{compute_worst_alternatives}
\title{Copute the worst and best alternatives}
\usage{
compute_best_alternatives(scores_per_alternative, ignoreRegex = NULL)

compute_worst_alternatives(scores_per_alternative, ignoreRegex = NULL)
}
\arguments{
\item{scores_per_alternative}{The `scores_per_alternative` object as
returned by [compute_scores_per_alternative()].}

\item{ignoreRegex}{Optionally, a regular expression: alternative labels
matching this regular expression will not be eligible as best alternatives.}
}
\value{
A data frame.
}
\description{
Given the scores per alternative, return the worst or best alternatives for
each decision.
}
