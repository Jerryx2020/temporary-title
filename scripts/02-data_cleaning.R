#### Preamble ####
# Purpose: Cleans the raw DineSafe data into an analysis dataset and handles parsing issues
# Author: Jerry Xia
# Date: 24 September 2024
# Contact: Jerry.xia@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to have downloaded the data
# Any other information needed? None.

#### Workspace setup ####
library(tidyverse)

# Load raw data and exclude the problematic "Min. Inspections Per Year" column (8th column): contains char where expected is a double
dinesafe_data <- read_csv("data/raw_data/dinesafe_data.csv", col_select = -`Min. Inspections Per Year`)

#### Clean data ####

# Step 1: Remove unnecessary columns (we already removed Min. Inspections Per Year)
cleaned_data <- dinesafe_data %>%
  select(`Establishment ID`, `Establishment Name`, `Establishment Type`, Severity, Outcome, Action)

# Step 2: Handle missing values
cleaned_data <- cleaned_data %>%
  filter(!is.na(`Establishment Name`) & `Establishment Name` != "",
         !is.na(`Establishment Type`) & `Establishment Type` != "",
         !is.na(Outcome) & Outcome != "")

# Fill missing severity values with "N/A - Not Applicable"
cleaned_data <- cleaned_data %>%
  mutate(Severity = ifelse(is.na(Severity), "N/A - Not Applicable", Severity))

# Step 3: Standardize all 57 establishment types into broader categories
cleaned_data <- cleaned_data %>%
  mutate(establishment_category = case_when(
    `Establishment Type` %in% c("Restaurant", "Café", "Bar", "Food Take Out", "Food Court Vendor", 
                                "Cocktail Bar / Beverage Room", "Private Club", "Banquet Facility") ~ "Restaurants & Eateries",
    
    `Establishment Type` %in% c("Supermarket", "Convenience Store", "Butcher Shop", "Fish Shop", "Bakery", 
                                "Food Store (Convenience/Variety)", "Bake Shop", "Food Depot") ~ "Food Stores",
    
    `Establishment Type` %in% c("Retirement Homes(Licensed)", "Nursing Home / Home for the Aged", "Hospitals & Health Facilities", 
                                "Child Care - Food Preparation", "Institutional Food Services", "Secondary School Food Services", 
                                "Other Educational Facility Food Services", "Community Kitchen (Meal Program)", 
                                "Retirement Homes(Un-licensed)", "Boarding / Lodging Home - Kitchen") ~ "Food Services for Institutions",
    
    `Establishment Type` %in% c("Food Truck", "Hot Dog Cart", "Mobile Food Preparation Premises", "Catering Vehicle", 
                                "Flea Market", "Fairs / Festivals / Special Occasions", "Farmers` Market Vendor") ~ "Mobile/Temporary Food Services",
    
    `Establishment Type` %in% c("Food Processing Plant", "Meat Processing Plant", "Milk Products Plant", "Ice Cream Plant", 
                                "Ice Manufacturing Plant", "Milk Pasteurization Plant", "Bottling Plant", "Locker Plant") ~ "Specialty Food Production",
    
    TRUE ~ "Other"
  ))

# Step 4: Ensure all text data is properly formatted (e.g., trimming spaces, capitalization)
cleaned_data <- cleaned_data %>%
  mutate(across(everything(), str_trim))  # Trim any leading/trailing white spaces

#### Save data ####
# Save the cleaned dataset for analysis
write_csv(cleaned_data, "data/analysis_data/cleaned_dinesafe_data.csv")
