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

# Set the number of records you want to simulate
number_of_records <- 1000

# All 57 establishment types
establishment_types <- c("Food Depot", "Food Take Out", "Food Store (Convenience/Variety)",
                         "Centralized Kitchen", "Restaurant", "Food Processing Plant", 
                         "Food Caterer", "Community Kitchen (Meal Program)", 
                         "Retirement Homes(Licensed)", "Boarding / Lodging Home - Kitchen", 
                         "Bakery", "Cocktail Bar / Beverage Room", "Cafeteria - Private Access", 
                         "Food Bank", "Mobile Food Preparation Premises", "Private Club", 
                         "Supermarket", "Cafeteria - Public Access", "Food Court Vendor", 
                         "Child Care - Food Preparation", "Flea Market", "Child Care - Catered", 
                         "Butcher Shop", "Fish Shop", "Student Nutrition Site", 
                         "Fairs / Festivals / Special Occasions", "Serving Kitchen", 
                         "Commissary", "Institutional Food Services", "Secondary School Food Services", 
                         "Other Educational Facility Food Services", "Hot Dog Cart", 
                         "Banquet Facility", "Bake Shop", "Food Vending Facility", 
                         "Nursing Home / Home for the Aged", "Chartered Cruise Boats", 
                         "Ice Cream / Yogurt Vendors", "College / University Food Services", 
                         "Rest Home", "Elementary School Food Services", 
                         "Refreshment Stand (Stationary)", "Brew Your Own Beer / Wine", 
                         "Hospitals & Health Facilities", "Food Cart", "Church Banquet Facility", 
                         "Farmers` Market Vendor", "Catering Vehicle", "Locker Plant", 
                         "Bed & Breakfast", "Bottling Plant", "Meat Processing Plant", 
                         "Milk Products Plant", "Ice Manufacturing Plant", 
                         "Milk Pasteurization Plant", "Ice Cream Plant", 
                         "Retirement Homes(Un-licensed)")

# Simulating inspection outcomes (e.g., Pass, Conditional Pass, Closed)
outcomes <- c("Pass", "Conditional Pass", "Closed")

# Simulating severity levels for infractions (e.g., C - Crucial, M - Minor, S - Significant)
severity_levels <- c("", "C - Crucial", "M - Minor", "S - Significant", "N/A - Not Applicable")

# Simulating available actions (based on dataset)
actions <- c("Notice to Comply", "Closure Order", "Corrected During Inspection", 
             "Not in Compliance", "Summons", "Summons and Health Hazard Order", 
             "Ticket", "Education Provided", "Recommendations", 
             "Prohibition Order Requested", "Warning Letter", "Order")

# Simulating the frequency of inspections using establishment ID (indicating repeated inspections)
number_of_inspections <- sample(1:5, number_of_records, replace = TRUE)  # Simulating up to 5 inspections per establishment

# Simulating the DineSafe data
simulated_data <- 
  tibble(
    establishment_id = rep(paste("ID", 1:(number_of_records/5), sep = "_"), each = 5),  # Simulating repeated inspections by ID
    establishment_name = rep(paste("Establishment", 1:(number_of_records/5), sep = "_"), each = 5),
    establishment_type = sample(establishment_types, number_of_records, replace = TRUE),
    inspection_frequency = number_of_inspections,
    severity = sample(severity_levels, number_of_records, replace = TRUE),
    outcome = sample(outcomes, number_of_records, replace = TRUE),
    action = sample(actions, number_of_records, replace = TRUE)
  )

#### Write to CSV ####
write_csv(simulated_data, file = "data/raw_data/simulated_dinesafe.csv")
