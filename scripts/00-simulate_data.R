#### Preamble ####
# Purpose: Simulates relevant DineSafe inspection data based on the actual dataset structure
# Author: Jerry Xia
# Date: 24 September 2024
# Contact: Jerry.xia@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None.

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(304)

# Set the number of records to simulate
number_of_records <- 1000

# Establishment types (limited to relevant categories: Restaurant and Food Take Out)
establishment_types <- c("Restaurant", "Food Take Out")

# Simulating severity levels for infractions (e.g., C - Crucial, M - Minor, S - Significant)
severity_levels <- c("C - Crucial", "M - Minor", "S - Significant")

# Simulating the frequency of inspections using establishment ID
number_of_inspections <- sample(1:5, number_of_records, replace = TRUE)

# Simulating DineSafe-like data
simulated_data <- 
  tibble(
    establishment_id = rep(paste("ID", 1:(number_of_records/5), sep = "_"), each = 5),  # Each establishment inspected up to 5 times
    establishment_type = sample(establishment_types, number_of_records, replace = TRUE),
    inspection_frequency = number_of_inspections,
    severity = sample(severity_levels, number_of_records, replace = TRUE),
  )

#### Write to CSV ####
write_csv(simulated_data, file = "data/raw_data/simulated_dinesafe.csv")
