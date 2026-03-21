# Project Walkthrough

## 1. Project Overview

This project was my final project for ALY6040: Data Mining at Northeastern University.

I used a public U.S. gun violence dataset to study patterns in incidents from January 2013 to March 2018. I wanted to understand where incidents were more common, when they happened more often, what participant patterns showed up, and whether I could build a model to identify higher-casualty incidents.

This repository is my cleaned public version for portfolio use. It keeps the main story simple and readable, but it also keeps the original project files so the work still feels real and traceable.

## 2. My Role

This was an individual course project.

I completed the analysis and report on my own. My work included:

- data cleaning
- missing value checks
- feature engineering
- exploratory data analysis
- participant-series parsing
- word cloud analysis
- model testing and comparison
- final report writing

I also looked at Kaggle notebooks and discussion posts to improve my approach, especially for handling complex variables and model ideas.

See:
- [`../contribution-note.md`](../contribution-note.md)
- [`../archive/reflection/individual-reflection.pdf`](../archive/reflection/individual-reflection.pdf)

## 3. Business Problem

The main question was not only what happened, but also:

1. What factors may predict more severe incidents?
2. Are there times of the year when incidents happen more often?
3. Which incidents are more likely to have multiple casualties?
4. How do local factors connect to high incident rates in some states?

This made the project a mix of descriptive analysis and basic predictive modeling.

## 4. Dataset

### Main dataset
- **Name:** Gun Violence Dataset
- **Source:** Kaggle
- **Time range:** January 2013 to March 2018
- **Size:** 239,677 rows and 29 columns

### Main fields used
- incident_id
- date
- state
- city_or_county
- n_killed
- n_injured
- congressional_district
- latitude
- longitude
- location_description
- participant_age
- participant_gender
- participant_status
- participant_type
- incident_characteristics

### Data note

```r
gun_data <- read.csv("data/raw/gun-violence-data_01-2013_03-2018.csv")
```

If the raw dataset is not included in the repo, please check:
- [`../data/README.md`](../data/README.md)

## 5. Tools

- **Language:** R
- **Main packages:** tidyverse, lubridate, ggplot2, splitstackshape, tidytext, wordcloud, caret, fastDummies, randomForest
- **Models tested:** Logistic Regression, KNN, LightGBM, Random Forest
- **Main public write-up focus:** EDA, word cloud analysis, and Random Forest summary

See:
- [`../scripts/01_full_analysis.R`](../scripts/01_full_analysis.R)
- [`../scripts/packages-used.md`](../scripts/packages-used.md)

## 6. Workflow

My project flow was:

1. Load the dataset
2. Check data types, unique values, missing values, and duplicates
3. Explore outliers in `n_killed` and `n_injured`
4. Create time-based features like year, quarter, month, and weekday
5. Analyze incident patterns by state, city, month, quarter, and weekday
6. Parse participant-related string fields into usable rows
7. Build word clouds from `location_description`
8. Create `total_casualties`
9. Create `high_casualty` as a binary target
10. Test several models
11. Compare results and write recommendations

## 7. Selected Code References

### Full analysis script
- [`../scripts/01_full_analysis.R`](../scripts/01_full_analysis.R)

### Report source
- [`../scripts/02_final_report_source.Rmd`](../scripts/02_final_report_source.Rmd)

### Original model output
- [`../archive/model-output/model-output.txt`](../archive/model-output/model-output.txt)

## 8. Key EDA Findings

### A. Incidents increased over time
From 2014 to 2017, the total number of incidents increased steadily.

### B. Some time patterns were clear
Incidents were more frequent on weekends, especially Sunday and Saturday. January, March, and summer months also showed higher counts than later months like November and December.

### C. Geographic concentration was strong
Illinois, California, Florida, and Texas had high incident counts. Chicago stood out as the top city in total incidents.

### D. Participant patterns were also clear
Most participants were marked as unharmed, then injured, arrested, and killed. The most common ages were around 18 to 26, and most participants were male.

### E. Location words showed common environments
The most common location words included apartments, parks, schools, and neighborhoods.

### Time and trend visuals

<p align="center">
  <img src="../outputs/figures/selected/number-of-incidents-by-year-2013-2018.jpeg" alt="Number of incidents by year" width="48%">
  <img src="../outputs/figures/selected/incidents-by-month-2014-2018.jpeg" alt="Incidents by month" width="48%">
</p>

<p align="center">
  <img src="../outputs/figures/selected/incidents-by-weekday.jpeg" alt="Incidents by weekday" width="48%">
  <img src="../outputs/figures/selected/incidents-by-quarter-and-year.jpeg" alt="Incidents by quarter and year" width="48%">
</p>

### Geography visuals

<p align="center">
  <img src="../outputs/figures/selected/top-states-by-incident-frequency.jpeg" alt="Top states by incident frequency" width="48%">
  <img src="../outputs/figures/selected/top-10-cities-by-number-of-incidents.jpeg" alt="Top cities by number of incidents" width="48%">
</p>

<p align="center">
  <img src="../outputs/figures/selected/number-of-gun-incidents-by-state-in-the-us.jpeg" alt="Gun incidents by state in the US" width="70%">
</p>

### Participant visuals

<p align="center">
  <img src="../outputs/figures/selected/distribution-of-participant-statuses.jpeg" alt="Distribution of participant statuses" width="48%">
  <img src="../outputs/figures/selected/top-10-most-common-participant-ages.jpeg" alt="Top participant ages" width="48%">
</p>

<p align="center">
  <img src="../outputs/figures/selected/gender-distribution-of-participants.jpeg" alt="Gender distribution of participants" width="48%">
  <img src="../outputs/figures/selected/top-10-most-common-incident-characteristics.jpeg" alt="Top incident characteristics" width="48%">
</p>

### Word cloud visuals

<p align="center">
  <img src="../outputs/figures/selected/wordcloud-1.jpeg" alt="Wordcloud 1" width="48%">
  <img src="../outputs/figures/selected/wordcloud-2.jpeg" alt="Wordcloud 2" width="48%">
</p>

## 9. Feature Engineering for Modeling

To represent incident severity, I created:

```r
gun_data_encoded$total_casualties <- gun_data_encoded$n_killed + gun_data_encoded$n_injured
gun_data_encoded$high_casualty <- ifelse(gun_data_encoded$total_casualties >= 3, 1, 0)
```

I also:
- one-hot encoded state, month, and weekday
- scaled numeric predictors
- split the data into training and testing sets

## 10. Modeling Note

I tested Logistic Regression, KNN, LightGBM, and Random Forest.

For this public GitHub version, I use the final report version as the main modeling reference.

Why:
- it is the most complete written version
- it matches the main R workflow more closely
- it gives a more realistic interpretation of the imbalanced classification problem

### Main public takeaway
Random Forest was the strongest model among the tested options, but the class imbalance problem was still serious.

### Final report metrics used here
- Accuracy: 97.45%
- Precision: 86.67%
- Recall: 2.94%
- F1 Score: 5.68%

### What that means
The model looked strong on accuracy, but it still missed many true high-casualty incidents. So the model was useful as a learning result, but not strong enough for a real decision system.

### Important public note
Some values shown in the original presentation slides are much higher than the final report version. I keep the slide deck in this repo as an original course artifact, but the public project story here follows the final report and original script more conservatively.

### Model evaluation visual

<p align="center">
  <img src="../outputs/figures/selected/roc-curve.jpeg" alt="ROC curve" width="48%">
  <img src="../outputs/figures/selected/auc-of-pr-curve.jpeg" alt="Precision recall curve" width="48%">
</p>

## 11. Main Insights From the Model

The final report highlighted these important factors:
- state_house_district
- state_senate_district
- year
- congressional_district
- quarter
- n_guns_involved
- some month features

This suggests that time and geographic context mattered a lot in the model.

See:
- [`../archive/model-output/model-output.txt`](../archive/model-output/model-output.txt)

## 12. Limitations

This project has some clear limitations:

- strong class imbalance in the target
- missing values in several columns
- limited external context variables
- some model versions took a long time to run
- some slide materials reflect an earlier or different experiment version and should not be treated as the final public reference

## 13. What I Learned

This project helped me practice a full workflow instead of only one part of analysis.

I learned how to:
- clean a large messy dataset
- work with multi-value text fields
- turn raw incident data into time and location insights
- compare model outputs more carefully
- explain why a high accuracy score can still be misleading

## 14. Files to Read First

If you want the shortest path through this repo, I suggest this order:

1. [`../README.md`](../README.md)
2. [`../reports/portfolio-project-summary.pdf`](../reports/portfolio-project-summary.pdf)
3. [`../reports/final-report.pdf`](../reports/final-report.pdf)
4. [`../outputs/figures/selected/`](../outputs/figures/selected/)
5. [`../scripts/01_full_analysis.R`](../scripts/01_full_analysis.R)
6. [`../data/README.md`](../data/README.md)

## 15. Short Interview Version

This was my individual final project for a data mining course. I used a U.S. gun violence dataset in R to study time, location, and participant patterns, and I also tested models for higher-casualty incident prediction. The main value of the project was the full workflow: cleaning data, parsing complex fields, finding useful EDA patterns, and then honestly evaluating the limits of the model instead of only showing a high accuracy number.