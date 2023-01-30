# Install CRAN packages
install.packages("devtools", "tidyverse", "viridis", "glmnet", "knitr", "kableExtra", "htmltools")

# Install Bioconductor packages
bioc_packages <- c("org.Hs.eg.db", "ReactomePA", "enrichplot", )

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install(bioc_packages)

# Install disgenet2r from repo and, before that, the archived SPARQL library it needs.
require(devtools)
install_version("SPARQL", version = "1.16", repos = "http://cran.us.r-project.org")
install_bitbucket("ibi_group/disgenet2r")
