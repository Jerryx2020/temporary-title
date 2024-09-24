#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Jerry Xia
# Date: 24 September 2024
# Contact: Jerry.xia@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
# Load required libraries
library(opendatatoronto)  # For accessing Open Data Toronto
library(tidyverse)        # For data manipulation and saving

#### Download data ####
# Fetch the DineSafe package using its package ID
package <- show_package("b6b4f3fb-2e2c-47e7-931d-b87d22806948")

# Get all available resources in this package
resources <- list_package_resources("b6b4f3fb-2e2c-47e7-931d-b87d22806948")

# Identify datastore resources (CSV/GeoJSON) and filter to CSV for non-geospatial data
datastore_resources <- filter(resources, tolower(format) == 'csv')

# Load the first datastore resource (DineSafe data)
dinesafe_data <- get_resource(datastore_resources$id[1])

#### Save data ####
# Save the downloaded data to a CSV file in the raw data folder
write_csv(dinesafe_data, "data/raw_data/dinesafe_data.csv")
