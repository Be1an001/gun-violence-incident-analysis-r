# Scripts

This repo keeps the original project analysis in R.

## Main File

- `01_full_analysis.R`

This is the full original analysis script I used for the project.

It includes:

- data loading
- data cleaning and missing value review
- EDA
- participant-series parsing
- word cloud analysis
- Random Forest modeling
- additional model experiments that were not all kept in the final report

## Why I Kept the Original Script

I did not fully rewrite the project into a production-style pipeline because I wanted to preserve the original course workflow.

For a GitHub visitor, the best reading order is:

1. `../README.md`
2. `../walkthrough/project-walkthrough.md`
3. `01_full_analysis.R`

## Before Running the Script

1. download the dataset and place it in `../data/raw/`
2. update the file path if needed
3. install the packages listed in `packages-used.md`

## Related Files

- [Project walkthrough](../walkthrough/project-walkthrough.md)
- [Final report](../reports/ALY6040_Gun_Violence_Final_Report.pdf)
- [Slides](../slides/ALY6040_Gun_Violence_Presentation.pdf)
- [Archive source Rmd](../archive/source-docs/Module_6_Final_Project.Rmd)
- [Model output notes](../archive/model-output/Model_Output.txt)
