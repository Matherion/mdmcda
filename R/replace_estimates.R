#' @export
replace_estimates <- function(multiEstimateDf,
                              criteria,
                              scorer,
                              transformationFunction,
                              decision = NULL,
                              decision_alternative_value = NULL,
                              criterion = NULL,
                              silent = FALSE,
                              ...) {

  if (!(scorer %in% names(multiEstimateDf))) {
    stop("Specified scorer ('", scorer,
         "') does not exist as a column in the object passed ",
         "as estimates object!");
  }

  decisionSelection <-
    ufs::ifelseObj(is.null(decision),
                   rep(TRUE, nrow(multiEstimateDf)),
                   multiEstimateDf$decision_id==decision);
  decision_alternative_valueSelection <-
    ufs::ifelseObj(is.null(decision_alternative_value),
                   rep(TRUE, nrow(multiEstimateDf)),
                   multiEstimateDf$decision_alternative_value==decision_alternative_value);

  if (all(criterion %in% criteria$convenience$childCriteriaByCluster)) {
    criterionSelectionList <- criterion;
    criterionSelection <-
      multiEstimateDf$criterion_id %in% criterionSelectionList;
  } else if (all(criterion %in% criteria$convenience$parentCriteriaIds)) {
    criterionSelectionList <- unlist(criteria$convenience$childCriteriaIds[[criterion]]);
    criterionSelection <-
      multiEstimateDf$criterion_id %in% criterionSelectionList;
  } else {
    criterionSelection <-
      rep(TRUE, nrow(multiEstimateDf));
    criterionSelectionList <-
      criteria$convenience$childCriteriaByCluster;
  }

  rowsToReplace <-
    decisionSelection & decision_alternative_valueSelection & criterionSelection;

  if (!silent) {
    ufs::cat0("\n- For decision ",
              ufs::vecTxtQ(decision),
              ", alternatives ",
              ifelse(is.null(decision_alternative_value),
                     "*",
                     ufs::vecTxtQ(decision_alternative_value)),
              ", and criteria ",
              ufs::vecTxtQ(criterionSelectionList),
              ", replacing ", sum(rowsToReplace), " estimates.\n");
  }

  for (currentCriterion in criterionSelectionList) {
    multiEstimateDf[rowsToReplace &
                      (multiEstimateDf$criterion_id == currentCriterion),
                    scorer] <-
      transformationFunction(multiEstimateDf[rowsToReplace &
                                               (multiEstimateDf$criterion_id == currentCriterion),
                                             scorer],
                             decision = decision,
                             decision_alternative_value = decision_alternative_value,
                             criterion = currentCriterion,
                             ...);
  }

  return(multiEstimateDf);

}