#### Preamble ####
# Purpose: Simulates DineSafe inspection data
# Author: Jerry Xia
# Date: 24 September 2024
# Contact: Jerry.xia@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(304)
2
# Define the start and end date for inspection dates
start_date <- as.Date("2018-01-01")
end_date <- as.Date("2023-12-31")

# Set the number of simulated inspections
number_of_inspections <- 1000

# Simulate random establishment names (100 unique establishments)
establishment_names <- paste("Restaurant", sample(LETTERS, 100, replace = TRUE), sample(1:100, 100, replace = TRUE))

# Simulate random establishment types
establishment_types <- c("Restaurant", "Café", "Food Truck", "Grocery Store", "Food Processing Facility")

# Simulate random inspection outcomes
inspection_outcomes <- c("Pass", "Conditional Pass", "Closed")

# Simulate random violation types
violation_types <- c("Improper Handwashing", "Inadequate Temperature Control", "Unclean Food Preparation Area", "Cross-Contamination", "Expired Food")

# Generate simulated data
simulated_data <-
  tibble(
    # Randomly assign establishments
    establishment_name = sample(establishment_names, number_of_inspections, replace = TRUE),
    
    # Assign random establishment types
    establishment_type = sample(establishment_types, number_of_inspections, replace = TRUE),
    
    # Generate random inspection dates
    inspection_date = as.Date(runif(n = number_of_inspections,
                                    min = as.numeric(start_date),
                                    max = as.numeric(end_date)),
                              origin = "1970-01-01"),
    
    # Randomly assign inspection outcomes
    inspection_outcome = sample(inspection_outcomes, number_of_inspections, replace = TRUE, prob = c(0.7, 0.2, 0.1)),
    
    # Randomly assign violations for each inspection (can be none or multiple violations)
    violations = map_chr(1:number_of_inspections, ~ paste(sample(violation_types, sample(0:3, 1, prob = c(0.3, 0.4, 0.2, 0.1)), replace = TRUE), collapse = ", ")),
    
    # Simulate fine amounts, with more severe violations having higher fines
    fine_amount = if_else(inspection_outcome == "Closed", sample(seq(500, 5000, by = 500), number_of_inspections, replace = TRUE), 0)
  )

#### Write to CSV ####
write_csv(simulated_data, file = "data/raw_data/simulated_dinesafe.csv")

