#' @export
details_estimates <- function(estimates,
                              heading = "Details of estimates",
                              headingLevel = 2,
                              pdfCols = c(2, 4, 6, 7, 8, 9),
                              pdfColLabels = c("Decision",
                                               "alternative",
                                               "Criterion",
                                               "Value",
                                               "Label",
                                               "Description"),
                              pdfColWidths = c("2cm", "1.5cm", "2cm",
                                               "1cm", "4cm", "4cm")) {

  ### If we're not knitting, immediately return the decision
  ### dataframe
  if (is.null(knitr::opts_knit$get("rmarkdown.pandoc.to"))) {
    return(estimates$estimatesDf);
  }

  if (is.null(heading)) {
    res <- "\n\n";
  } else {
    res <- paste0("\n\n",
                  repStr("#", headingLevel),
                  " ",
                  heading,
                  "\n\n");
  }

  if (!(length(pdfCols) == length(pdfColLabels) &&
        length(pdfColLabels) == length(pdfColWidths))) {
    stop("Exactly equal lengths have to be provided for the ",
         "arguments 'pdfCols', 'pdfColLabels', and 'pdfColWidths'.");
  }

  if (knitr::is_latex_output()) {
    table <-
      knitr::kable(estimates$estimatesDf[, pdfCols],
                   format="latex",
                   row.names = FALSE,
                   col.names=pdfColLabels,
                   booktabs = TRUE, longtable = TRUE);
    for (i in seq_along(pdfCols)) {
      table <-
        kableExtra::column_spec(table,
                                column = i,
                                width = pdfColWidths[i]);
    }
  } else {
    table <-
      knitr::kable(estimates$estimatesDf,
                   row.names = FALSE);
  }

  res <-
    paste0(res,
           paste0(table,
                  collapse="\n"));

  res <- knitr::asis_output(res);

  return(res);
}
