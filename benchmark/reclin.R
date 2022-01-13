# Sampling fraction
keep_frac <- 0.4

args <- commandArgs(trailingOnly = TRUE)
if (length(args)) {
  keep_frac <- as.numeric(args[1])
  stopifnot(!is.na(keep_frac) && keep_frac > 0 && keep_frac <= 1)
}
cat("keep_frac=", keep_frac, "\n", sep="")


suppressPackageStartupMessages({
library(reclin)
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


#blocking_var <- "enumpc"
blocking_var <- character(0)
comparison_vars <- setdiff(c("pername1", "pername2", "sex", "dob_day", 
  "dob_mon", "dob_year", "enumpc"), blocking_var)

comparators <- list(
  "pername1" = jaro_winkler(0.85),
  "pername2" = jaro_winkler(0.85)
)

if (length(blocking_var)) { 
  p <- pair_blocking(x, y, blocking_var = blocking_var, 
    large = FALSE)
} else {
  p <- pair_blocking(x, y, blocking_var = NULL, large = FALSE)
}

npairs <- nrow(p)
cat("npairs=", npairs, "\n", sep = "")

p <- compare_pairs(p, by = comparison_vars, comparators = comparators)

m <- problink_em(p)

p <- score_problink(p, m)

if (FALSE) {

  thresholds <- seq(3, 5, length.out = 10)
  nerr <- numeric(length(thresholds))
  p <- add_from_x(p, person_id_x = "person_id")
  p <- add_from_y(p, person_id_y = "person_id")
  p$true <- p$person_id_x == p$person_id_y
  for (i in seq_along(thresholds)) {
    p <- select_greedy(p, weight = "weight", 
      threshold = thresholds[i])
    tab <- table(p[, c("select", "true")], useNA = "ifany")
    nerr[i] <- tab[2,1] + tab[1,2]
  }
  data.frame(thresholds, nerr)
  # 4.6

}

p <- add_from_x(p, person_id_x = "person_id")
p <- add_from_y(p, person_id_y = "person_id")
p$true <- p$person_id_x == p$person_id_y
p <- select_greedy(p, weight = "weight", 
  threshold = 4.6)
tab <- table(p[, c("select", "true")], useNA = "ifany")

nerr <- tab[2,1] + tab[1,2]
precision <- tab[2,2]/(tab[2,2] + tab[2,1])
recall    <- tab[2,2]/(tab[2,2] + tab[1,2])

cat("Confusion matrix\n")
print(tab)
cat("\n")
cat("nerrors=", nerr, "\n", sep = "")
cat("precision=", precision, "\n", sep = "")
cat("recall=", recall, "\n", sep = "")


