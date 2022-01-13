# Sampling fraction
keep_frac <- 0.4

args <- commandArgs(trailingOnly = TRUE)
if (length(args)) {
  keep_frac <- as.numeric(args[1])
  stopifnot(!is.na(keep_frac) && keep_frac > 0 && keep_frac <= 1)
}
cat("keep_frac=", keep_frac, "\n", sep="")



suppressPackageStartupMessages({
library(reclin2)
})

x <- fread("../ons-example/data-clean/cis.csv", stringsAsFactors = FALSE, 
  data.table = TRUE)

y <- fread("../ons-example/data-clean/prd.csv", stringsAsFactors = FALSE, 
  data.table = TRUE)

enumpcs <- unique(c(x$enumpc, y$enumpc))
set.seed(1)
enumpcs <- sample(enumpcs, round(length(enumpcs)*keep_frac))
x <- x[x$enumpc %in% enumpcs, ]
y <- y[y$enumpc %in% enumpcs, ]


#blocking_var <- "enumpc"
blocking_var <- character(0)
comparison_vars <- setdiff(c("pername1", "pername2", "sex", "dob_day", 
  "dob_mon", "dob_year", "enumpc"), blocking_var)

comparators <- list(
  "pername1" = jaro_winkler(0.85),
  "pername2" = jaro_winkler(0.85)
)

if (length(blocking_var)) { 
  p <- pair_blocking(x, y, on = blocking_var)
} else {
  p <- pair(x, y)
}

npairs <- nrow(p)
cat("npairs=", npairs, "\n", sep = "")

compare_pairs(p, on = comparison_vars, comparators = comparators, 
  inplace = TRUE)

formula <- as.formula(paste0("~", paste0(comparison_vars, collapse="+")))

m <- problink_em(formula, data = p)

p <- predict(m, newdata = p, inplace = TRUE, add = TRUE, type = "weights")

if (FALSE) {
  thresholds <- seq(3, 5, length.out = 10)
  nerr <- numeric(length(thresholds))

  for (i in seq_along(thresholds)) {
    select_greedy(p, score = "weights", variable = "sel", 
      threshold = thresholds[i], inplace = TRUE)
    compare_vars(p, "person_id", inplace = TRUE)
    tab <- table(p[, .(sel, person_id)], useNA = "ifany")
    nerr[i] <- tab[2,1] + tab[1,2]
  }
  data.table(thresholds, nerr)
  # 4.6
}

select_greedy(p, score = "weights", variable = "sel", 
  threshold = 4.6, inplace = TRUE)
compare_vars(p, "person_id", inplace = TRUE)
tab <- table(p[, .(sel, person_id)], useNA = "ifany")
nerr <- tab[2,1] + tab[1,2]

precision <- tab[2,2]/(tab[2,2] + tab[2,1])
recall    <- tab[2,2]/(tab[2,2] + tab[1,2])

cat("Confusion matrix\n")
print(tab)
cat("\n")
cat("nerrors=", nerr, "\n", sep = "")
cat("precision=", precision, "\n", sep = "")
cat("recall=", recall, "\n", sep = "")


