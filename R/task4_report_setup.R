require(org.Hs.eg.db)
require(ReactomePA)

# Load the input generated by dvt_analysis.R
report_input <- readRDS(paste0("reports/", run_name, "_report_input.Rds"))

# Create HTML markdown report.
rmarkdown::render("R/task4_report.Rmd",
                  knit_root_dir = getwd(),
                  output_file = paste0("../reports/", run_name, "_report.html")
)
