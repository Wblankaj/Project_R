pkgname <- "DataFrame"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
base::assign(".ExTimings", "DataFrame-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('DataFrame')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("DataFrame-package")
### * DataFrame-package

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: DataFrame-package
### Title: Package offers multiple ML preprocessing functions.
### Aliases: DataFrame-package DataFrame
### Keywords: package

### ** Examples

# create artificial data frame
df <- data.frame(x = 1:5, y = c("c", "a", "b", "a", "c"), z = c("a", "a", "b", "a", "b"))
# change class of data frame to DataFrame
df <- DataFrame(df)

# dtypes conversion
numcols <- c("x")
fctcols <- c("y", "z")
df <- astype.DataFrame(df, numeric.cols = numcols, factor.cols = fctcols)
str(df)

#encoding
encoding.DataFrame(df, fctcols, type = "one-hot", drop = "binary")
encoding.DataFrame(df, fctcols, type = "ordinal", drop = FALSE)

train_test <- train_test_split.DataFrame(df, test.size = 0.3, random.state = 34, stratify="z")
train_test$train
train_test$test

train_test <- train_test_split.DataFrame(df, test.size = 0.3, random.state = 34)
train_test$train
train_test$test



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("DataFrame-package", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("DataFrame")
### * DataFrame

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: DataFrame
### Title: Creates DataFrame object from a given data frame.
### Aliases: DataFrame

### ** Examples

## Not run: 
##D # create artificial data frame
##D df <- data.frame(x = 1:3, y = 3:1, z = c("a", "a", "b"))
##D # change class of data frame to DataFrame
##D df <- DataFrame(df)
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("DataFrame", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("GeneratePlot.DataFrame")
### * GeneratePlot.DataFrame

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: GeneratePlot.DataFrame
### Title: GeneratePlot function
### Aliases: GeneratePlot.DataFrame

### ** Examples

## Not run: 
##D # Generate distribution plot for the "value" column
##D plot_dist <- GeneratePlot(data, column = "value", plot_type = "distribution")
##D plot_dist
##D 
##D # Generate boxplot for the "value" column
##D plot_box <- GeneratePlot(data, column = "value", plot_type = "boxplot")
##D plot_box
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("GeneratePlot.DataFrame", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("HandleMissingValues.DataFrame")
### * HandleMissingValues.DataFrame

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: HandleMissingValues.DataFrame
### Title: GeneratePlot function
### Aliases: HandleMissingValues.DataFrame

### ** Examples


## Not run: 
##D # Generate distribution plot for the "value" column
##D plot_dist <- GeneratePlot(data, column = "value", plot_type = "distribution")
##D plot_dist
##D 
##D # Generate boxplot for the "value" column
##D plot_box <- GeneratePlot(data, column = "value", plot_type = "boxplot")
##D plot_box
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("HandleMissingValues.DataFrame", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("astype.DataFrame")
### * astype.DataFrame

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: astype.DataFrame
### Title: ~~astype.DataFrame: convert columns data type~~
### Aliases: astype.DataFrame

### ** Examples

# create artificial data frame
df <- data.frame(x = 1:3, y = 3:1, z = c("a", "a", "b"))
# change class of data frame to DataFrame
df <- DataFrame(df)
# dtypes conversion
numcols <- c("x", "y")
fctcols <- c("z")
astype.DataFrame(df, numeric.cols = numcols, factor.cols = fctcols)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("astype.DataFrame", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("custom_normalize.DataFrame")
### * custom_normalize.DataFrame

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: custom_normalize.DataFrame
### Title: Custom Data Frame Normalization Function
### Aliases: custom_normalize.DataFrame

### ** Examples

# Example usage:
# Creating a sample data frame
my_data_frame <- data.frame(
  NumericColumn1 = c(10, 20, 30, 40, 50),
  NumericColumn2 = c(1.5, 2.5, 3.5, 4.5, 5.5),
  CategoricalColumn = c("A", "B", "A", "B", "A")
)

# Changing class of data frame to DataFrame
my_data_frame <- DataFrame(my_data_frame)

# Standardize numeric columns in a data frame
result_standardize <- custom_normalize.DataFrame(my_data_frame, method = "standardize")


# Min-Max normalize numeric columns in a data frame
result_min_max <- custom_normalize.DataFrame(my_data_frame, method = "min_max")




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("custom_normalize.DataFrame", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("encoding.DataFrame")
### * encoding.DataFrame

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: encoding.DataFrame
### Title: ~~encoding.DataFrame: convert to perform columns encoding~~
### Aliases: encoding.DataFrame

### ** Examples

# create artificial data frame
df <- data.frame(x = 1:3, y = c("c", "a", "b"), z = c("a", "a", "b"))
# change class of data frame to DataFrame
df <- DataFrame(df)

# dtypes conversion
numcols <- c("x")
fctcols <- c("y", "z")
df <- astype.DataFrame(df, numeric.cols = numcols, factor.cols = fctcols)
str(df)

#encoding
encoding.DataFrame(df, fctcols, type = "one-hot", drop = "binary")
encoding.DataFrame(df, fctcols, type = "ordinal", drop = FALSE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("encoding.DataFrame", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.DataFrame")
### * summary.DataFrame

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.DataFrame
### Title: Summary Statistics for Data Frame
### Aliases: summary.DataFrame

### ** Examples

# Example usage:
# Creating a sample data frame
my_data_frame <- data.frame(
  NumericColumn1 = c(10, 20, 30, 40, 50),
  NumericColumn2 = c(1.5, 2.5, 3.5, 4.5, 5.5),
  CategoricalColumn = c("A", "B", "A", "B", "A")
)

# Changing class of data frame to DataFrame
my_data_frame <- DataFrame(my_data_frame)

result <- summary.DataFrame(my_data_frame)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.DataFrame", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("train_test_split.DataFrame")
### * train_test_split.DataFrame

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: train_test_split.DataFrame
### Title: ~~train_test_split.DataFrame: performs train-test split ~~
### Aliases: train_test_split.DataFrame

### ** Examples

# create artificial data frame
df <- data.frame(x = 1:5, y = c("c", "a", "b", "a", "c"), z = c("a", "a", "b", "a", "b"))
# change class of data frame to DataFrame
df <- DataFrame(df)

# dtypes conversion
numcols <- c("x")
fctcols <- c("y", "z")
df <- astype.DataFrame(df, numeric.cols = numcols, factor.cols = fctcols)
str(df)

train_test <- train_test_split.DataFrame(df, test.size = 0.3, random.state = 34, stratify="z")
train_test$train
train_test$test

train_test <- train_test_split.DataFrame(df, test.size = 0.3, random.state = 34)
train_test$train
train_test$test



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("train_test_split.DataFrame", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
