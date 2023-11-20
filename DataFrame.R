DataFrame <- function(df, row.names, col.names, ...) UseMethod("DataFrame")
DataFrame <- function(df, row.names, col.names, ...) {
  
  stopifnot(is.data.frame(df))
  # rename index
  if(!missing(row.names)) {
    rownames(df) <- row.names
  }
  # rename columns
  if(!missing(col.names)) {
    colnames(df) <- col.names
  }
  
  class(df) <- list('DataFrame', 'data.frame')
  return(df)
}


summary.DataFrame <- function(df) {
  
  numeric_stats <- list()
  categorical_stats <- list()
  
  for (col in names(df)) {
    # Check if the column is numerical
    if (is.numeric(df[[col]])) {
      summary_stats <- c(
        Mean = mean(df[[col]], na.rm = TRUE),
        Median = median(df[[col]], na.rm = TRUE),
        SD = sd(df[[col]], na.rm = TRUE),
        Variance = var(df[[col]], na.rm = TRUE),
        Min = min(df[[col]], na.rm = TRUE),
        Max = max(df[[col]], na.rm = TRUE),
        Range = diff(range(df[[col]], na.rm = TRUE)),
        Quantile_25 = quantile(df[[col]], probs = 0.25, na.rm = TRUE),
        Quantile_75 = quantile(df[[col]], probs = 0.75, na.rm = TRUE),
        Missing = as.integer(sum(is.na(df[[col]])))
      )
      numeric_stats[[col]] <- summary_stats
    } else {
      # For categorical data, get frequency table
      categorical_stats[[col]] <- table(df[[col]])
    }
  }
  
  # Formatting the results for numeric data
  if (length(numeric_stats) > 0) {
    #numeric_stats_df <- data.frame(t(sapply(numeric_stats, unlist)))
    numeric_stats_df <- data.frame(do.call(rbind, numeric_stats))
    colnames(numeric_stats_df) <- names(summary_stats)
    #numeric_stats <- data.frame(numeric_stats)
    
    numeric_stats_df[,-ncol(numeric_stats_df)] <- round(numeric_stats_df[,-ncol(numeric_stats_df) ], 2)
  } else {
    numeric_stats_df <- NULL
  }
  
  
  list(
    Numeric = numeric_stats_df,
    Categorical = categorical_stats
  )
}


astype.DataFrame <- function(df, numeric.cols, factor.cols) {
  
  if(!missing(numeric.cols)) {
    # convert columns to numeric
    for(ncol in numeric.cols) {
      df[, ncol] <- as.numeric(df[, ncol])
    }
  }
  # convert columns to factors
  if(!missing(factor.cols)) {
    for(fcol in factor.cols) {
      df[, fcol] <- as.factor(df[, fcol])
    }
  }
  return(df)
}


train_test_split.DataFrame <- function(df, test.size = 0.3, random.state = 47, stratify){
  
  set.seed(random.state)
  
  stopifnot(test.size >= 0 || test.size <= 1)
  train.size <- 1- test.size
  
  # stratified train test split
  if(!missing(stratify)) {
    # assert the column used for stratification is in dataframe
    stopifnot(stratify %in% colnames(df))
    # assert the column is categorical
    stopifnot(is.factor(df[[stratify]]))
    # assert the column takes more than 1 unique value
    stopifnot(length(unique(df[[stratify]])) > 1)
    
    if (!requireNamespace("caret", quietly = TRUE))
      install.packages("caret")
    
    indx <- caret::createDataPartition(df[, stratify], p = train.size, list = FALSE)
    
  } else { # not stratified train test split
    indx <- sample(1:nrow(df), size = (train.size)*nrow(df))
  }
  train_data <- df[indx, ]
  test_data <-  df[-indx, ]
  return(list(train = train_data, test = test_data))
}


encoding.DataFrame <- function(df, col.names, type = "ordinal", drop = FALSE) {
  
  if (!is.list(col.names)) {
    stopifnot(is.character(col.names))
    col.names <- c(col.names)
  }
  
  # ordinal encoding
  if (type=="ordinal") {
    for(col in col.names) {
      df[, col] <- as.numeric(factor(df[[col]], levels = unique(df[[col]]), exclude = NULL))
    }
  }
  # one-hot encoding
  else if (type=="one-hot") {
    for(col in col.names) {
      
      if(!is.factor(df[[col]])) {
        df[, col] <- as.factor(df[, col])
      }
      # encoding
      encoded.df <- model.matrix(~0 + df[ , col])
      encoded.df.colnames <- sprintf(paste(col, '.%s', sep = "") , unique(df[ , col]))
      colnames(encoded.df) <- encoded.df.colnames
      
      col.pos <- match(col, colnames(df))
      new.colnames <- append(colnames(df), colnames(encoded.df), col.pos)
      new.colnames <- new.colnames[new.colnames != col]
      
      # concatenating data frames
      if (col.pos == ncol(df)){
        df <- cbind(df[,1:col.pos-1], encoded.df)
      } else {
        df <- cbind(df[,1:col.pos-1], cbind(encoded.df, df[,(col.pos+1):ncol(df)]))
      }
      colnames(df) <- new.colnames
      df <- data.frame(df)
      class(df) <- list('DataFrame', 'data.frame')
      
      # dropping one category
      stopifnot(drop %in% c(FALSE, TRUE, "last", "first", "binary"))
      if (drop == "last" || drop == TRUE ) {
        df <- df[ , !names(df) %in% c(colnames(encoded.df)[ncol(encoded.df)])]
      } else if (drop == "first") {
        df <- df[ , !names(df) %in% c(colnames(encoded.df)[1])]
      } else if (drop == "binary") {
        if (ncol(encoded.df) == 2) {
          df <- df[ , !names(df) %in% c(colnames(encoded.df)[2])]
        }
      }
      
    }
  }
  return(df)
}

custom_normalize.DataFrame <- function(df, method = "standardize") {
  # Check if the input is a data frame
  stopifnot(is.data.frame(df))
  
  # Separate numeric and non-numeric columns
  numeric_columns <- sapply(df, is.numeric)
  df_numeric <- df[, numeric_columns]
  df_non_numeric <- df[, !numeric_columns]
  
  # Apply standardization/normalization method to numeric columns
  if (method == "standardize") {
    # Standardization (centering and scaling)
    df_numeric <- scale(df_numeric)
  }
  else if (method == "min_max") {
    # Min-Max Normalization
    df_numeric <- apply(df_numeric, 2, function(x) (x - min(x)) / (max(x) - min(x)))
  }
  else if (method == "log_transform") {
    # Log transformation
    df_numeric <- log1p(df_numeric)
  }
  else if (method == "robust") {
    # Robust standardization
    df_numeric <- apply(df_numeric, 2, function(x) (x - median(x)) / IQR(x))
  }
  else if (method == "z_score") {
    # Z-Score normalization
    df_numeric <- apply(df_numeric, 2, function(x) (x - mean(x)) / sd(x))
  }
  
  
  # Combine numeric and non-numeric columns back into a single data frame
  df <- cbind(df_non_numeric, df_numeric)
  
  # Return the processed table
  return(df)
}


GeneratePlot.DataFrame <- function(data, column, plot_type = "distribution") {
  # Check if the specified column exists in the data frame
  if (!(column %in% names(data))) {
    stop("Specified column not found in the data frame.")
  }
  
  # Generate either a distribution plot or a boxplot based on the plot_type
  if (plot_type == "distribution") {
    # Create a distribution plot for the specified column
    plot <- plot(density(data[[column]]), main = paste("Distribution Plot for", column),
                 xlab = column, col = "skyblue", lwd = 2)
    polygon(density(data[[column]]), col = rgb(0.2, 0.5, 0.8, 0.5), border = NA)
  } else if (plot_type == "boxplot") {
    # Create a boxplot for the specified column
    plot <- boxplot(data[[column]], main = paste("Boxplot for", column),
                    xlab = column, col = "skyblue", border = "darkblue", plot = FALSE)
  } else {
    stop("Invalid plot_type. Supported types are 'distribution' and 'boxplot'.")
  }
  
  return(plot)
}


HandleMissingValues.DataFrame <- function(data, method = "drop", columns = NULL) {
  
  # Check the validity of arguments
  stopifnot(is.data.frame(data))
  stopifnot(is.character(method) && method %in% c("drop", "zero", "mean", "median", "mode", "interpolate"))
  stopifnot(is.null(columns) || (is.character(columns) && all(columns %in% names(data))))
  
  # If columns is specified, filter the columns to those in the list
  if (!is.null(columns)) {
    modifieddata <- data[, columns, drop = FALSE]
  } else {
    modifieddata <- data
  }
  
  if (method == "drop") {
    # Remove rows with missing values in selected columns
    data <- data[complete.cases(modifieddata), ]
  }
  
  else {
    # Apply the specified method to each selected column
    for (col in names(modifieddata)) {
      
      missingvalues <- sum(is.na(modifieddata[[col]]))
      
      if (missingvalues > 0) {
        if (method == "zero") {
          data[[col]][is.na(data[[col]])] <- 0
        } else if (method %in% c("mean", "median", "mode")) {
          imputevalue <- switch(method,
                                mean = mean(data[[col]], na.rm = TRUE),
                                median = median(data[[col]], na.rm = TRUE),
                                mode = {
                                  # Create a frequency table, find the value with the highest frequency
                                  tbl <- table(data[[col]], useNA = "ifany")
                                  mode_value <- as.numeric(names(tbl)[which.max(tbl)])
                                  # If NA is the most frequent value, use the second most frequent value
                                  if (is.na(mode_value)) {
                                    mode_value <- as.numeric(names(tbl)[which.max(tbl[-which.max(tbl)])])
                                  }
                                  mode_value
                                })
          data[[col]][is.na(data[[col]])] <- imputevalue
        } else if (method == "interpolate") {
          # Interpolate missing values in the column using linear interpolation
          interpolatedvalues <- approx(seq_along(data[[col]]), data[[col]], method = "linear", na.rm = TRUE)$y
          data[[col]] <- interpolatedvalues  # Replace the original column with the interpolated values
        }
      }
    }
  }
  return(data)
}

df <- data.frame(x = 1:3, y = c("c", "a", "b"), z = c("a", "a", "b"))
# change class of data frame to DataFrame
df <- DataFrame(df)
custom_normalize.DataFrame(df, method = "max-min")
