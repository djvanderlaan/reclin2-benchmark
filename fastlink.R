# Sampling fraction
keep_frac <- 0.1

args <- commandArgs(trailingOnly = TRUE)
if (length(args)) {
  keep_frac <- as.numeric(args[1])
  stopifnot(!is.na(keep_frac) && keep_frac > 0 && keep_frac <= 1)
}
cat("keep_frac=", keep_frac, "\n", sep="")


suppressPackageStartupMessages({
library(fastLink)
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



matches <- fastLink(
  dfA = x, dfB = y,
  varnames = comparison_vars,
  stringdist.match = c("pername1", "pername2"),
  cut.a = 0.85,
  n.cores = 4
  )



m <- matches$matches
positives <- x$person_id[m[,1]] == y$person_id[m[,2]]
positives <- factor(positives, levels = c(FALSE, TRUE))
tab1 <- table(positives)
print(tab1)
stopifnot(length(tab1) == 2)

x$true_match <- match(x$person_id, y$person_id)
x$match <- NA_real_
x$match[m[,1]] <- m[,2]

xsel <- x[!is.na(x$true_match), ]
tab2 <- table(is.na(xsel$match) | xsel$true_match != xsel$match)
stopifnot(length(tab2) == 2)

fp <- tab1[1]
fn <- tab2[2]
tp <- tab1[2]
stopifnot(tab1[2] == tab2[1])
nerr <- fp+fn
precision <- tp/(fp+tp)
recall    <- tp/(fn+tp)

cat("Confusion matrix\n")
cat("\n")
cat("nerrors=", nerr, "\n", sep = "")
cat("precision=", precision, "\n", sep = "")
cat("recall=", recall, "\n", sep = "")


