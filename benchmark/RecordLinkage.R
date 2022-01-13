# Sampling fraction
keep_frac <- 0.1

args <- commandArgs(trailingOnly = TRUE)
if (length(args)) {
  keep_frac <- as.numeric(args[1])
  stopifnot(!is.na(keep_frac) && keep_frac > 0 && keep_frac <= 1)
}
cat("keep_frac=", keep_frac, "\n", sep="")


suppressPackageStartupMessages({
library(RecordLinkage)
})

x <- data.table::fread("../ons-example/data-clean/cis.csv", 
  stringsAsFactors = FALSE, data.table = FALSE)

y <- data.table::fread("../ons-example/data-clean/prd.csv", 
  stringsAsFactors = FALSE, data.table = FALSE)

enumpcs <- unique(c(x$enumpc, y$enumpc))
set.seed(1)
enumpcs <- sample(enumpcs, round(length(enumpcs)*keep_frac))
x <- x[x$enumpc %in% enumpcs, ]
y <- y[y$enumpc %in% enumpcs, ]

# Remove unneeded columns as these mess with the RecordLinkage
# functions 
x$cis_id <- NULL
x$enumcap <- NULL
y$prd_id <- NULL
stopifnot(all(names(x) == names(y)))

#blocking_var <- "enumpc"
blocking_var <- character(0)
comparison_vars <- setdiff(c("pername1", "pername2", "sex", "dob_day", 
  "dob_mon", "dob_year", "enumpc"), blocking_var)

exclude <- setdiff(names(x), comparison_vars)


p <- compare.linkage(x, y, exclude = exclude,
  identity1 = x$person_id, identity2 = y$person_id,
  strcmp = match(c("pername1", "pername2"), names(x)))

npairs <- nrow(p$pairs)
cat("npairs=", npairs, "\n", sep = "")


p <- emWeights(p, cutoff = 0.85)

if (FALSE) {

  thresholds <- seq(12, 15, length.out = 10)
  nerr <- numeric(length(thresholds))
  for (i in seq_along(thresholds)) {
    res <- emClassify(p, threshold.upper = thresholds[i])
    tab <- table(res$pairs$is_match, res$prediction)
    nerr[i] <- tab[2,1] + tab[1,3]
  }
  data.frame(thresholds, nerr)
  # 14.3
}


# optimalThreshold gives a completely wrong threshold
#threshold <- optimalThreshold(p)
threshold <- 14.3

res <- emClassify(p, threshold.upper = threshold)

tab <- table(res$pairs$is_match, res$prediction)
tab <- tab[, c(1,3)]


nerr <- tab[2,1] + tab[1,2]
precision <- tab[2,2]/(tab[2,2] + tab[2,1])
recall    <- tab[2,2]/(tab[2,2] + tab[1,2])

cat("Confusion matrix\n")
print(tab)
cat("\n")
cat("nerrors=", nerr, "\n", sep = "")
cat("precision=", precision, "\n", sep = "")
cat("recall=", recall, "\n", sep = "")


