library(data.table)
library(ggplot2)

files <- list.files("results", "*.txt")

d <- gsub( ".txt$", "", files)
d <- strsplit(d, "-")
method <- sapply(d, function(d) d[1])
samplefrac <- sapply(d, function(d) d[2])
samplefrac <- as.numeric(samplefrac)

i <- 1
lines <- readLines(file.path("results", files[i]))

result <- vector("list", length(files))
for (i in seq_along(files)) {
  lines <- readLines(file.path("results", files[i]))
  nerrors <- sapply(strsplit(lines[grep("^nerrors=", lines)], "="), \(x) as.numeric(x[2]))
  precision <- sapply(strsplit(lines[grep("^precision=", lines)], "="), \(x) as.numeric(x[2]))
  recall <- sapply(strsplit(lines[grep("^recall=", lines)], "="), \(x) as.numeric(x[2]))
  keep_frac <- sapply(strsplit(lines[grep("^keep_frac=", lines)], "="), \(x) as.numeric(x[2]))
  maxmem <- sapply(strsplit(lines[grep("Maximum resident set size", lines)], ":"), \(x) as.numeric(x[2]))
  elapsedtime_str <- strsplit(lines[grep("(wall clock)", lines)], "):")[[1]][2]
  elapsedtime <- sapply(strsplit(elapsedtime_str, ":")[[1]], as.numeric)
  stopifnot(length(elapsedtime) == 2)
  elapsedtime <- sum(elapsedtime * c(60, 1))
  npairs <- NA_real_
  p <- grep("npairs=", lines)
  if (length(p)) {
    npairs <- sapply(strsplit(lines[grep("^npairs=", lines)], "="), \(x) as.numeric(x[2]))
  }
  result[[i]] <- data.table(method = method[i], nerrors, precision, recall, keep_frac, maxmem,
    elapsedtime, elapsedtime_str, npairs)
}
result <- rbindlist(result)

result[, npairs := mean(npairs, na.rm = TRUE), by = keep_frac]



result[method == "reclin2_cluster", method := "reclin2_cluster4"]
result[method == "fastlink", method := "fastLink"]
result[, method := gsub("_cluster", " cluster-", method)]
result[, method := factor(method, levels = c("fastLink", "reclin", "reclin2", "reclin2 cluster-4", 
  "reclin2 cluster-8", "reclin2 cluster-16", "RecordLinkage"))]

pal <- hcl.colors(nlevels(result$method), "Dynamic")
names(pal) <- levels(result$method)


ggplot(result, aes(x = npairs, y = elapsedtime/60, color = method)) + geom_point() +
  geom_line() + scale_color_manual(values = pal) + theme_bw() + 
  xlab("Number of potential pairs") + ylab("Time (min)") + 
  labs(color = "Package/method")
ggsave("benchmark_time.pdf", width = 8, heigh = 5)

tmp <- result[!grepl("cluster", result$method),]
tmp[, method := factor(method)]
paltmp <- pal[!grepl("cluster", names(pal))]
ggplot(tmp, aes(x = npairs, y = maxmem/1E6, color = method)) + geom_point() +
  geom_line() + scale_color_manual(values = paltmp) + theme_bw() + 
  xlab("Number of potential pairs") + ylab("Max. memory use (GB)") + 
  labs(color = "Package/method")
ggsave("benchmark_memory.pdf", width = 8, heigh = 5)

# Speedup of fastlink over reclin2 for largest problem
t1 <- result$elapsedtime[result$method == "reclin2 cluster-16"]
t2 <- result$elapsedtime[result$method == "fastLink"]
tail(t1, 1)/tail(t2, 1)
