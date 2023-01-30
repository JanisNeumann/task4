#### Dependencies ####
library(tidyverse)
library(disgenet2r)
library(org.Hs.eg.db)
library(pacman)
pacman::p_load("ReactomePA", install = TRUE, try.bioconductor = TRUE, update.bioconductor = TRUE)



#### Definitions ####

padjust_threshold <- 0.05
FC_threshold <- 1



#### Load Data ####

# Either loads data provided by arguments or just use the example data.
data_full <- read.csv(gene_data)

# Very basic checks to see if the included file will work.
# For actual use cases, this would need to be expanded.
stopifnot(colnames(data_full) == c("Symbol", "logFC", "pValue", "adj.pValue"))
stopifnot(nrow(data_full) > 0)



#### Initial Analysis ####

# Record down- and upregulation according to p-value & log fold change
ia_regulation <- rep("Abs. log FC < 1", nrow(data_full))
ia_regulation[data_full$adj.pValue <= padjust_threshold & data_full$logFC <= -FC_threshold] <- "Downregulated"
ia_regulation[data_full$adj.pValue <= padjust_threshold & data_full$logFC >= FC_threshold] <- "Upregulated"
ia_regulation <- factor(ia_regulation, levels = c("Abs. log FC < 1", "Downregulated", "Upregulated"))

# Creates a data frame that lists the number of measured protein,
# those that are significantly differently expressed, and those which are
# down- (log fold change -1 or below) or upregulated (log FC 1 or higher).
ia_table <- data.frame(
  Group = c("Measured", "Significant", "Downregulated", "Upregulated"),
  Sum = c(
    nrow(data_full),
    sum(data_full$adj.pValue <= padjust_threshold),
    sum(ia_regulation == "Downregulated"),
    sum(ia_regulation == "Upregulated")
  )
)

# Visualization of the above using a volcano plot.
# Code here is only for the data that will eventually be used for the report.
ia_volcano_data <- data.frame(dplyr::select(data_full, -pValue),
                              Significant = as.factor(ifelse(data_full$adj.pValue <= padjust_threshold, "Yes", "No")),
                              Regulation = ia_regulation
)
rm(ia_regulation)



#### Retained Data ####

# Subset the data to retain genes/proteins with adj. p-value <= 0.05 & abs. log FC >= 1
data_retained <- data_full[data_full$adj.pValue <= padjust_threshold & abs(data_full$logFC) >= FC_threshold, ]



#### Disease Association ####

# Get gene to disease associations from DisGeNet
g2d_data <- gene2disease(data_retained$Symbol,
                         vocabulary = "HGNC",
                         database = "CURATED",
                         score = c(0.6, 1),
                         verbose = FALSE,
                         warnings = TRUE
)



#### REACTOME encrichment ####

# Get Entrez IDs of provided HGNC symbols.
entrez_ids <- na.omit(mapIds(org.Hs.eg.db, data_retained$Symbol, "ENTREZID", "SYMBOL"))

# Perform enrichment analysis using ReactomePA
rpe_results <- ReactomePA::enrichPathway(gene = entrez_ids, pvalueCutoff = 0.05, readable = TRUE)


#### Output ####

report_input <- list(
  padjust_threshold = padjust_threshold,
  FC_threshold = FC_threshold,
  ia_table = ia_table,
  ia_volcano_data = ia_volcano_data,
  data_retained = data_retained,
  g2d_data = g2d_data,
  rpe_results = rpe_results
)

# Create reports directory if it doesn't exist.
if (!dir.exists("reports")){
  dir.create("reports")
}

saveRDS(report_input, paste0("reports/", run_name, "_report_input.Rds"))
