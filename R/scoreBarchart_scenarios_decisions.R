#' @export
scoreBarchart_scenarios_decisions <- function (weighedEstimates,
                                               estimateCol,
                                               strokeSize = .1,
                                               strokeColor = "black",
                                               title = "DMCDA bar chart to compare scenarios",
                                               xLab = "Scenario",
                                               yLab = "Weighed estimated effect") {

  res <-
    ggplot2::ggplot(data = weighedEstimates[, c("scenario_id",
                                                "decision_id",
                                                "criterion_id",
                                                estimateCol)],
                    mapping = ggplot2::aes_string(x='scenario_id',
                                                  y=estimateCol,
                                                  fill='decision_id')) +
    ggplot2::geom_col(color =strokeColor,
                      size=strokeSize) +
    ggplot2::scale_fill_viridis_d(name = "Decision") +
    ggplot2::scale_x_discrete(position="bottom") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x.bottom = ggplot2::element_text(angle = 90,
                                                              hjust = 1,
                                                              vjust = 0.5)) +
    ggplot2::labs(title=title,
                  subtitle = paste0("Colours represent decisions, ",
                                    "separate rectangles per criterion"),
                  x=xLab,
                  y=yLab) +
    NULL;
  return(res);
}