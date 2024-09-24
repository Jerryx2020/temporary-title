#### Preamble ####
# Purpose: Simulates DineSafe inspection data based on the actual dataset structure
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

# Define the start and end date for inspection simulation
start_date <- as.Date("2018-01-01")
end_date <- as.Date("2023-12-31")

# Set the number of records you want to simulate
number_of_records <- 100

# Simulating establishment types (e.g., restaurant, food truck, etc.)
establishment_types <- c("Restaurant", "Café", "Food Truck", "Bakery", "Bar")

# Simulating inspection outcomes (e.g., Pass, Conditional Pass, Closed)
outcomes <- c("Pass", "Conditional Pass", "Closed")

# Simulating infraction severity levels (e.g., S - Significant, M - Minor, C - Crucial)
severity_levels <- c("S", "M", "C")

# Simulating the DineSafe data
simulated_data <- 
  tibble(
    establishment_name = paste("Establishment", 1:number_of_records),
    establishment_type = sample(establishment_types, number_of_records, replace = TRUE),
    inspection_date = as.Date(
      runif(
        n = number_of_records,
        min = as.numeric(start_date),
        max = as.numeric(end_date)
      ),
      origin = "1970-01-01"
    ),
    severity = sample(severity_levels, number_of_records, replace = TRUE),
    outcome = sample(outcomes, number_of_records, replace = TRUE),
    amount_fined = rpois(number_of_records, lambda = 100) * 10 # Simulating fines with a Poisson distribution
  )

#### Write to CSV ####
write_csv(simulated_data, file = "data/raw_data/simulated_dinesafe.csv")
