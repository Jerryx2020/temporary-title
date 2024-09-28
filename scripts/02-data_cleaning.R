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

# Step 1: Select relevant columns for analysis
cleaned_data <- dinesafe_data %>%
  select(`Establishment ID`, `Establishment Type`, `Severity`, `Establishment Status`, `Inspection Date`)

# Step 2: Filter to only "Pass" status and remove the Establishment Status column
cleaned_data <- cleaned_data %>%
  filter(`Establishment Status` == "Pass") %>%
  select(-`Establishment Status`)  # Drop the status column after filtering

# Step 3: Update the Severity column
# - Replace blank (empty string) values with "No Infraction"
# - Replace NA values with "N/A - No Infraction"
cleaned_data <- cleaned_data %>%
  mutate(Severity = case_when(
    Severity == "" ~ "No Infraction",  # If Severity is a blank string, set it to "No Infraction"
    is.na(Severity) ~ "No Infraction",  # If Severity is NA, set it to "N/A - No Infraction"
    TRUE ~ Severity  # Keep all other values as they are
  ))

# Step 4: Filter data to only include Restaurants and Food Take Out
cleaned_data <- cleaned_data %>%
  filter(`Establishment Type` %in% c("Restaurant", "Food Take Out"))
# Step 5: Filter data to remove establishments with no inspection date
cleaned_data <- cleaned_data %>%
  filter(!is.na(`Inspection Date`))

# Step 6: Ensure date format is consistent
cleaned_data <- cleaned_data %>%
  mutate(`Inspection Date` = as.Date(`Inspection Date`, format="%Y-%m-%d"))

#### Save data ####
# Save the cleaned dataset for analysis
write_csv(cleaned_data, "data/analysis_data/cleaned_dinesafe_data.csv")