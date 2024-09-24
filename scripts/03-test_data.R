#### Preamble ####
# Purpose: Sanity check of the DineSafe data
# Author: Jerry Xia
# Date: 24 September 2024
# Contact: Jerry.xia@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to have cleaned data
# Any other information needed? None.

#### Workspace setup ####
library(tidyverse)

#### Test data ####
# Load the cleaned data
data <- read_csv("data/analysis_data/analysis_data.csv")

# 1. Test for negative fines
test_negative_fines <- all(data$amount_fined >= 0)
if (!test_negative_fines) {
  message("Warning: There are negative fine values in the data.")
}

# 2. Test for missing values in key columns (inspection_date, outcome, severity)
test_missing_values <- data |>
  select(inspection_date, outcome, severity) |>
  summarise(across(everything(), ~ sum(is.na(.))))

if (any(test_missing_values > 0)) {
  message("Warning: There are missing values in key columns.")
} else {
  message("No missing values in key columns.")
}

# 3. Test for valid severity levels
valid_severity_levels <- c("S", "M", "C")
test_severity_levels <- all(data$severity %in% valid_severity_levels)
if (!test_severity_levels) {
  message("Warning: There are invalid severity levels in the data.")
}

# 4. Test for valid outcomes (Pass, Conditional Pass, Closed)
valid_outcomes <- c("Pass", "Conditional Pass", "Closed")
test_outcomes <- all(data$outcome %in% valid_outcomes)
if (!test_outcomes) {
  message("Warning: There are invalid outcomes in the data.")
}
