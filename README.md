# task4
A visual report of pathways, disease associations etc.


## What this does.

This repository visualizes differential expression of proteomics data and, following filtering based on adjusted detection p-value and log fold change, provides a table of the retained genes/proteins and plots disease association and pathway information.
The results are presented in a HTML markdown report with rudimentary CSS styling.


## Inputs

The required input is a .csv file with the following columns: "Symbol", "logFC", "pValue", "adj.pValue", with "Symbol" meaning HGNC annotation.
There is an example data set taken from Quirós et al. 2017, used by default.


## Workflow

1. Source R/task4dependencies.R
2. Review task4_config.R, specifically input your DisGeNet2 account details (email & password), and source the script.
3. Review the created HTML file in the reports subdirectory.

## Limitations & Opportunities

Unfortunately, this is currently lacking further automation & Docker integration since one of the essential packages did not function when used through a Docker image.
The attempt at a more automated workflow can be found here: https://github.com/JanisNeumann/data_viz_task
There are only rudimentary failsafes and the required columns could be changed. Support for different significance and log fold change thresholds could easily be added but would require further filtering in places due to the limitations of some plotting functions used.
CSS styling could be enhanced, and there is a stubborn issue with a warning text in Figure 3 to solve.)


## Citation (Data only)

Pedro M. Quirós, Miguel A. Prado, Nicola Zamboni, Davide D’Amico, Robert W. Williams, Daniel Finley, Steven P. Gygi, Johan Auwerx; Multi-omics analysis identifies ATF4 as a key regulator of the mitochondrial stress response in mammals. J Cell Biol 3 July 2017; 216 (7): 2027–2045. 
