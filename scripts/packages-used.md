# Packages Used

This note is based on the original R script used in this project. I did not record exact package versions during the course submission, so this is a practical package list rather than a full environment lock file.

## Core Data Work

- `tidyverse`
- `lubridate`
- `scales`
- `gridExtra`
- `ggrepel`
- `maps`
- `splitstackshape`

## Text Mining / Word Clouds

- `tidytext`
- `tm`
- `wordcloud`
- `RColorBrewer`

## Modeling and Evaluation

- `caret`
- `fastDummies`
- `randomForest`
- `PRROC`
- `pROC`
- `ModelMetrics`
- `class`
- `xgboost`
- `lightgbm`

## Notes

- The final public write-up mainly uses Random Forest as the model reference.
- The checked-in script also includes KNN and XGBoost experiments.
- Archived notes preserve additional LightGBM output from the original course work.
- Some original slide or archived model materials show stronger metrics than the final report. The public README and walkthrough use the more conservative final report metrics.
- This package list does not make the project production-ready; it is only meant to help rerun the original analysis.

## Simple Install Example

```r
install.packages(c(
  "tidyverse",
  "lubridate",
  "scales",
  "gridExtra",
  "ggrepel",
  "maps",
  "splitstackshape",
  "tidytext",
  "tm",
  "wordcloud",
  "RColorBrewer",
  "caret",
  "fastDummies",
  "randomForest",
  "PRROC",
  "pROC",
  "ModelMetrics",
  "class",
  "xgboost",
  "lightgbm"
))
```
