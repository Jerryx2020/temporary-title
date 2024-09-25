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
data <- read_csv("data/analysis_data/cleaned_dinesafe_data.csv")

# 1. Test for missing values in important columns (Establishment ID, Establishment Type, Severity, Inspection Date)
missing_values <- data %>%
  summarise(
    missing_establishment_id = sum(is.na(`Establishment ID`)),
    missing_establishment_type = sum(is.na(`Establishment Type`)),
    missing_severity = sum(is.na(Severity)),
    missing_inspection_date = sum(is.na(`Inspection Date`))
  )

print(missing_values)  # Check if there are missing values in critical columns

# 2. Test for invalid severity values
valid_severity_levels <- c("C - Crucial", "M - Minor", "S - Significant", "N/A - Not Applicable")
invalid_severity_values <- data %>%
  filter(!Severity %in% valid_severity_levels)

print(invalid_severity_values)  # Any rows where Severity is not a valid category will be shown

# 3. Test for completeness of key fields
# Are there any rows where key fields (Establishment ID, Establishment Type, Severity, Inspection Date) are completely missing?
complete_cases_check <- data %>%
  filter(is.na(`Establishment ID`) | is.na(`Establishment Type`) | is.na(Severity) | is.na(`Inspection Date`))

print(complete_cases_check)  # Output rows where any of the key fields are missing

# Test Results Summary
print("Sanity checks completed for DineSafe data.")
