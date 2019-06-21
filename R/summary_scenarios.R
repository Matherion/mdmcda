#' @export
summary_scenarios <- function(scenarios_and_alternatives,
                              header = "Summary of scenarios",
                              headerLevel = 2,
                              pdfCols = c(2, 3),
                              pdfColLabels = c("Scenario",
                                               "Description"),
                              pdfColWidths = c("3cm", "10cm")) {

  ### IF we're not knitting, immediately return the decision
  ### dataframe
  if (is.null(knitr::opts_knit$get("rmarkdown.pandoc.to"))) {
    return(scenarios_and_alternatives$scenariosMetadataDf);
  }

  if (is.null(header)) {
    res <- "\n\n";
  } else {
    res <- paste0("\n\n",
                  repStr("#", headerLevel),
                  " ",
                  header,
                  "\n\n");
  }

  if (!(length(pdfCols) == length(pdfColLabels) &&
        length(pdfColLabels) == length(pdfColWidths))) {
    stop("Exactly equal lengths have to be provided for the ",
         "arguments 'pdfCols', 'pdfColLabels', and 'pdfColWidths'.");
  }

  if ("pdf_document" %in% knitr::opts_knit$get("rmarkdown.pandoc.to")) {
    table <-
      knitr::kable(scenarios_and_alternatives$scenariosMetadataDf[, pdfCols],
                   row.names = FALSE,
                   col.names=pdfColLabels,
                   booktabs = TRUE, longtable = TRUE);
    for (i in seq_along(pdfCols)) {
      table <-
        kableExtra::column_spec(tale,
                                column = i,
                                width = pdfColWidths[i]);
    }
  } else {
    table <-
      knitr::kable(scenarios_and_alternatives$scenariosMetadataDf,
                   row.names = FALSE);
  }

  res <-
    paste0(res,
           paste0(table,
                  collapse="\n"));

  res <- knitr::asis_output(res);

  return(res);
}