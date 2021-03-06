#' @export
scenario_scores <- function(criteria,
                            decisions_and_alternatives,
                            estimates,
                            scenarios_and_alternatives,
                            weights) {

  criterionId_col      <- mdmcda::opts$get("criterionId_col");
  criterionLabel_col   <- mdmcda::opts$get("criterionLabel_col");
  decisionId_col       <- mdmcda::opts$get("decisionId_col");
  decisionLabel_col    <- mdmcda::opts$get("decisionLabel_col");
  alternativeValue_col <- mdmcda::opts$get("alternativeValue_col");
  alternativeLabel_col <- mdmcda::opts$get("alternativeLabel_col");
  scenarioId_col       <- mdmcda::opts$get("scenarioId_col");
  weightProfileId_col  <- mdmcda::opts$get("weightProfileId_col");
  score_col            <- mdmcda::opts$get("score_col");

  weightsDf <- weights$weightsDf;
  multipliedWeights <- weights$multipliedWeights;
  autofilledEstimatesDf <- estimates$autofilledEstimatesDf;
  scenarioAlternativesDf <- scenarios_and_alternatives$scenarioAlternativesDf;
  decisionsDf <- decisions_and_alternatives$decisionsDf;
  scenariosMetadataDf <- scenarios_and_alternatives$scenariosMetadataDf;
  criteriaDf <- criteria$criteriaDf;

  ### Select all multiplied estimates for each scenario
  scenarioScores <- list();
  scoringLog <- character();

  ### Separately per each weight profile
  for (currentScenario in scenariosMetadataDf$scenario_id) {
    scenarioScores[[currentScenario]] <- list();
    ### And per scenario
    for (currentWtProf in unique(weightsDf$weight_profile_id)) {
      scenarioScores[[currentScenario]][[currentWtProf]] <- data.frame();
      ### And per instrument
      for (currentDecision in decisionsDf$id) {
        ### And only for the chosen alternative
        currentAlternative <-
          scenarioAlternativesDf[scenarioAlternativesDf$scenario_id==currentScenario &
                              scenarioAlternativesDf$decision_id==currentDecision, alternativeValue_col];
        if (length(currentAlternative) == 0) {
          scoringLog <- c(scoringLog,
                          paste0("For scenario '",
                                 currentScenario,
                                 "' and decision '",
                                 currentDecision,
                                 "', no alternative is selected!"));
        } else {
          ### And per criterion
          for (currentCriterion in criteriaDf$id[criteriaDf$leafCriterion]) {
            scoreSelection <-
              autofilledEstimatesDf$decision_id==currentDecision &
              autofilledEstimatesDf[, alternativeValue_col]==currentAlternative &
              autofilledEstimatesDf$criterion_id==currentCriterion;

            currentScore <-
              autofilledEstimatesDf[
                scoreSelection,
                paste0(currentWtProf, "___score")];

            scoringLog <- c(scoringLog,
                            paste0("For scenario '",
                                   currentScenario,
                                   "' and decision '",
                                   currentDecision,
                                   "', alternative '",
                                   currentAlternative
                                   , "' is selected. For criterion '",
                                   currentCriterion,
                                   "', this alternative has score '",
                                   currentScore,
                                   "' for weighing profile '",
                                   currentWtProf,
                                   "'."));

            if (length(currentScore) > 1) {
              warning("Multiple estimates were specified for scenario '",
                      currentScenario,
                      "', decision '",
                      currentDecision,
                      "', alternative '",
                      currentAlternative
                      , "', and criterion '",
                      currentCriterion,
                      "', weighing profile '",
                      currentWtProf,
                      "'! Specifically, ",
                      vecTxtQ(currentScore),
                      ". Take the mean of these estimates.");
              currentScore <- mean(currentScore,
                                   na.rm=TRUE);
            }

            if (is.null(currentScore) || is.na(currentScore)) {
              currentScore <- 0;
            }

            scenarioScores[[currentScenario]][[currentWtProf]] <-
              rbind(scenarioScores[[currentScenario]][[currentWtProf]],
                    data.frame(scenario_id = currentScenario,
                               weight_profile_id = currentWtProf,
                               decision_id = currentDecision,
                               alternative_value = currentAlternative,
                               criterion_id = currentCriterion,
                               score = currentScore));
            names(scenarioScores[[currentScenario]][[currentWtProf]]) <-
              c(scenarioId_col,
                weightProfileId_col,
                decisionId_col,
                alternativeValue_col,
                criterionId_col,
                score_col
              );

          }
        }
      }
    }
  }

  res <-
    list(scenarioScores = scenarioScores,
         scoringLog = scoringLog);

  res$scoresDf <- data.frame();

  for (currentScenario in scenariosMetadataDf$scenario_id) {
    for (currentWeighingProfile in unique(weightsDf$weight_profile_id)) {
      res$scoresDf[nrow(res$scoresDf) + 1, 'scenario'] <- currentScenario;
      res$scoresDf[nrow(res$scoresDf), 'weightProfile'] <- currentWeighingProfile;
      res$scoresDf[nrow(res$scoresDf), 'score'] <-
        sum(scenarioScores[[currentScenario]][[currentWeighingProfile]]$score,
            na.rm=TRUE);
    }
  }

  class(res) <-
    c("dmcmda", "scenario_scores");

  return(invisible(res));

}
