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

# 1. Test for missing values in important columns (Establishment Name, Establishment Type, Outcome)
missing_values <- data %>%
  summarise(
    missing_establishment_name = sum(is.na(`Establishment Name`)),
    missing_establishment_type = sum(is.na(`Establishment Type`)),
    missing_outcome = sum(is.na(Outcome))
  )

print(missing_values)  # Check if there are missing values in critical columns

# 2. Test for invalid severity values
valid_severity_levels <- c("", "C - Crucial", "M - Minor", "S - Significant", "N/A - Not Applicable")
invalid_severity_values <- data %>%
  filter(!Severity %in% valid_severity_levels)

print(invalid_severity_values)  # Any rows where Severity is not a valid category will be shown

# 3. Test for invalid or empty action values
valid_action_levels <- c("Notice to Comply", "Closure Order", "Corrected During Inspection", 
                         "Not in Compliance", "Summons", "Summons and Health Hazard Order", 
                         "Ticket", "Education Provided", "Recommendations", 
                         "Prohibition Order Requested", "Warning Letter", "Order")

invalid_action_values <- data %>%
  filter(!Action %in% valid_action_levels)

print(invalid_action_values)  # Show any rows with invalid or missing actions

# 4. Test for completeness of key fields
# Are there any rows where key fields (Establishment Name, Type, Outcome, Action) are completely missing?
complete_cases_check <- data %>%
  filter(is.na(`Establishment Name`) | is.na(`Establishment Type`) | is.na(Outcome) | is.na(Action))

print(complete_cases_check)  # Output rows where any of the key fields are missing

# Test Results Summary
print("Sanity checks completed for DineSafe data.")
