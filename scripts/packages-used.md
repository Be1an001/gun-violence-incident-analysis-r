# Packages Used

This note is based on the original script used in this project.

I did not record the exact package versions during the original course submission, so this file is a practical package list, not a full environment lock file.

## Core Data Work

- `tidyverse`
- `lubridate`
- `scales`
- `gridExtra`
- `ggrepel`
- `maps`
- `splitstackshape`

## Text Mining / Word Cloud

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

- The final report mainly presents Random Forest as the main model.
- The full script also includes extra experiments such as KNN, XGBoost, and LightGBM.
- Some experimental model results were kept in notes or slides rather than fully explained in the final report.

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
  "xgboost"
))