# Scripts

This folder keeps the original R analysis files for the project.

## Main Files

- [`01_full_analysis.R`](01_full_analysis.R) - main R analysis script
- [`02_final_report_source.Rmd`](02_final_report_source.Rmd) - R Markdown source for the final report
- [`packages-used.md`](packages-used.md) - practical package list

## What the Main Script Includes

`01_full_analysis.R` includes:

- data loading
- data cleaning and missing value review
- duplicate and outlier checks
- time-feature engineering
- exploratory data analysis
- participant-field parsing
- word cloud analysis
- Random Forest modeling
- KNN and XGBoost experiments

The original course workflow was kept mostly as one script for traceability. I did not rewrite it into a production-style pipeline because this repository is meant to preserve the project as a course-based portfolio analysis.

## Before Running the Script

1. Download the Kaggle dataset.
2. Save it as:

   `../data/raw/gun-violence-data_01-2013_03-2018.csv`

3. Install the packages listed in [`packages-used.md`](packages-used.md).
4. Run [`01_full_analysis.R`](01_full_analysis.R) from this folder or from the repository root.

The script looks for the CSV in both `data/raw/` and `../data/raw/`.

## Model Note

The final public model reference is the Random Forest result from the final report and archived model output:

- Accuracy: 97.45%
- Precision: 86.67%
- Recall: 2.94%
- F1 Score: 5.68%

The model should be interpreted carefully because the high-casualty class is rare and recall is very weak. Older slide materials are kept as original course artifacts, but they should not be used as the final public model claim.

## Related Files

- [Project walkthrough](../walkthrough/project-walkthrough.md)
- [Final report](../reports/final-report.pdf)
- [Portfolio project summary](../reports/portfolio-project-summary.pdf)
- [Original presentation slides](../slides/original-presentation.pdf)
- [Model output notes](../archive/model-output/model-output.txt)
