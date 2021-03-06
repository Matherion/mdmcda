% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scoreBarchart_criteriaCluster.R
\name{scoreBarchart_criteriaCluster}
\alias{scoreBarchart_criteriaCluster}
\title{Create a bar chart with scores per criteria cluster}
\usage{
scoreBarchart_criteriaCluster(
  weighedEstimates,
  estimateCol,
  parentCriterionOrder = unique(weighedEstimates$parentCriterion_id),
  parentCriterionLabels = parentCriterion_ids,
  scenarioOrder = unique(weighedEstimates$scenario_id),
  scenarioLabels = scenario_ids,
  strokeColor = "black",
  strokeSize = 0.1,
  title = "MDMCDA criteria cluster bar chart",
  xLab = "Criteria Cluster",
  yLab = estimateCol,
  theme = ggplot2::theme_minimal(base_size = mdmcda::opts$get("ggBaseSize")),
  guides = ggplot2::guide_legend(nrow = 1),
  legend.position = "top"
)
}
\arguments{
\item{weighedEstimates}{A `weighedEstimates` object.}

\item{estimateCol}{The column name with the estimates to use.}

\item{strokeColor, strokeSize}{The color and pen width of the stroke.}

\item{title, xLab, yLab}{The title and x and y axis labels.}

\item{theme}{The `ggplot2` theme to use.}

\item{guides}{A guides argument to tweak the legend.}

\item{legend.position, legend.box.margin}{The position and spacing for the
legend.}

\item{parentCriterion_ids}{The parent criteria to include.}

\item{parentCriterion_labels}{The labels for the parent criteria.}

\item{scenario_ids}{The scenarios to include.}

\item{scenario_labels}{The labels for the scenarios.}
}
\value{
A `ggplot2` plot.
}
\description{
Create a bar chart with scores per criteria cluster
}
