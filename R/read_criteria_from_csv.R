#' @export
read_criteria_from_csv <- function(input,
                                   encoding = "UTF-8",
                                   showGraphs = TRUE,
                                   ...) {

  if (!file.exists(input)) {
    stop("Specified file ('", input, "') does not exist!");
  }

  fullCriteriaDf <-
    read.csv(input,
             stringsAsFactors =FALSE,
             encoding=encoding);

  criteriaDf <-
    fullCriteriaDf[, c('id',
                       'parentCriterion',
                       'label',
                       'description',
                       'isLeaf')];

  anchoringDf <-
    fullCriteriaDf[fullCriteriaDf$isLeaf,
                   c('id',
                     'lo_label',
                     'zero_label',
                     'hi_label',
                     'lo_score',
                     'hi_score')];

  anchoringDf$lo_score <-
    as.numeric(anchoringDf$lo_score);
  anchoringDf$hi_score <-
    as.numeric(anchoringDf$hi_score);

  anchoringGraphs <-
    anchoringDf_to_anchoringGraphs(anchoringDf=anchoringDf,
                                   criteriaDf=criteriaDf,
                                   showGraphs=showGraphs,
                                   ...);

  ### In data.tree, isLeaf is an active property, so we have to rename it
  names(criteriaDf)[names(criteriaDf) == "isLeaf"] <- "leafCriterion";

  criteriaTree <- data.tree::as.Node(criteriaDf, mode="network");

  ### Take first child, since the root element (e.g. 'outcomes' or
  ### 'criteria') will always have a parent in the spreadsheet)
  criteriaTree <- criteriaTree$children[[1]];

  res <- list(criteria = NA, ### Potentially add this if I ever write a YAML export function
              criteriaTree = criteriaTree,
              criteriaDf = criteriaDf,
              anchoringDf = anchoringDf,
              fullCriteriaDf = fullCriteriaDf,
              anchoringGraphs = anchoringGraphs);

  class(res) <-
    c("dmcda", "criteria");

  return(res);

}