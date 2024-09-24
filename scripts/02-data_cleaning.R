#### Preamble ####
# Purpose: Cleans the raw DineSafe data into an analysis dataset
# Author: Jerry Xia
# Date: 24 September 2024
# Contact: Jerry.xia@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to have downloaded the data
# Any other information needed? None.

#### Workspace setup ####
library(tidyverse)      # For data manipulation
library(janitor)        # For cleaning column names
library(lubridate)      # For working with dates

#### Clean data ####

# Read the raw DineSafe data
raw_data <- read_csv("data/raw_data/dinesafe_data.csv")

# Clean and prepare the data
cleaned_data <- raw_data |> 
  # Clean column names to snake_case for easier reference
  janitor::clean_names() |> 
  
  # Convert 'inspection_date' to Date format (if it's not already a date)
  mutate(inspection_date = ymd(inspection_date)) |> 
  
  # Standardize establishment types to title case (e.g., "restaurant" -> "Restaurant")
  mutate(establishment_type = str_to_title(establishment_type)) |> 
  
  # Replace blank or missing infraction details with NA
  mutate(infraction_details = ifelse(infraction_details == "", NA, infraction_details)) |> 
  
  # Convert fine_amount to numeric if it’s stored as text
  mutate(fine_amount = as.numeric(fine_amount)) |> 
  
  # Convert min_inspections_per_year into a factor with levels 1, 2, 3, and "O" for low-risk
  mutate(min_inspections_per_year = factor(min_inspections_per_year, levels = c("1", "2", "3", "O"))) |> 
  
  # Ensure there are no duplicates
  distinct()

#### Save cleaned data ####
# Save the cleaned data for analysis
write_csv(cleaned_data, "data/analysis_data/cleaned_dinesafe_data.csv")
