#### Preamble ####
# Purpose: Cleans the raw DineSafe data into an analysis dataset
# Author: Jerry Xia
# Date: 24 September 2024
# Contact: Jerry.xia@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to have downloaded the data
# Any other information needed? None.

#### Workspace setup ####
library(tidyverse)
library(janitor)    # For cleaning column names
library(lubridate)  # For date manipulation

#### Clean data ####
# Read in the raw DineSafe data
raw_data <- read_csv("data/raw_data/dinesafe_data.csv")

# Cleaning the data
cleaned_data <-
  raw_data |>
  janitor::clean_names() |> 
  mutate(
    inspection_date = ymd(inspection_date),  # Ensure inspection dates are in proper date format
    amount_fined = as.numeric(amount_fined), # Convert fines to numeric
    severity = factor(severity, levels = c("S", "M", "C")),  # Convert severity to a factor with meaningful levels
    outcome = factor(outcome)  # Convert outcome to factor for easy analysis
  ) |> 
  drop_na(inspection_date)  # Remove rows where inspection date is missing

#### Save cleaned data ####
# Save the cleaned data to the analysis_data folder
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
