
files <- list.files("results", "*.txt")


d <- gsub( ".txt$", "", files)
d <- strsplit(d, "-")
method <- sapply(d, function(d) d[1])
samplefrac <- sapply(d, function(d) d[2])
samplefrac <- as.numeric(samplefrac)

i <- 1
lines <- readLines(file.path("results", files[i]))

