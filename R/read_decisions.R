#' @export
read_decisions <- function(input,
                           extension = "jmd",
                           regex = NULL,
                           recursive = TRUE,
                           encoding = "UTF-8") {

  if (is.null(regex)) {
    regex <- paste0("^(.*)\\.", extension, "$");
  }

  ### Use suppressWarnings because we do not need identifiers
  suppressWarnings(
    decisions_raw <-
      justifier::read_justifications_dir(path=input,
                                         regex = regex,
                                         justificationContainer = 'decision',
                                         recursive = recursive,
                                         encoding=encoding)
  );

  decisions <-
    decisions_raw$raw;

  decisionsDf <-
    do.call(rbind,
            lapply(decisions,
                   function(x) {
                     return(data.frame(id = x$id,
                                       label = x$label,
                                       description = x$description,
                                       choices = vecTxt(paste0(purrr::map_chr(x$alternatives,
                                                                              "label"),
                                                               " (",
                                                               purrr::map_chr(x$alternatives,
                                                                              "value"),
                                                               ")")),
                                       stringsAsFactors = FALSE));
                   }));
  row.names(decisionsDf) <-
    NULL;

  miniPurrChr <- function(list, chr) {
    return(unlist(lapply(list, function(i) return(as.character(i[[chr]])))));
  }

  alternativesDf <-
    do.call(
      rbind,
      lapply(
        decisions,
        function(x) {
          return(
            data.frame(
              decision_id = rep(x$id, length(x$alternatives)),
              decision_label = rep(x$label, length(x$alternatives)),
              value = miniPurrChr(x$alternatives, "value"),
              label = miniPurrChr(x$alternatives, "label"),
              description = miniPurrChr(x$alternatives, "description"),
              stringsAsFactors = FALSE
            )
          );
        }));
  row.names(alternativesDf) <-
    NULL;

  res <- list(decisions_raw = decisions_raw,
              decisions = decisions,
              decisionsDf = decisionsDf,
              alternativesDf = alternativesDf);

  class(res) <-
    c("mdmcda", "decisions_and_alternatives");

  return(res);

}
