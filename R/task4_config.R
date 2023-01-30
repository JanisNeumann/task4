#### User Input ####

# Sets a run name.
run_name <- "example_run"

# This is unfortunately needed for the DisGeNet2R package.
disgenet2_email <- "janis.neumann@rub.de"
disgenet2_password <- "ZNXPi9BPa88QCFv"

# Sets the data to use, defaulting to example data that comes with the repository.
gene_data <- "data/example_data.csv"



#### Run Scripts

# Set up DisGeNet2R package.
source("R/task4_disgenet2r.R")

# Perform analysis of the data.
source("R/task4_analysis.R")

# Prepare report.
source("R/task4_report_setup.R")
