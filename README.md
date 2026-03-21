# \# Gun Violence Incident Analysis in R

# 

# This repo is a cleaned public version of my Fall 2024 ALY6040 Data Mining final project at Northeastern University. I used a U.S. gun violence incident dataset to study time patterns, location patterns, participant details, and high-casualty incident risk.

# 

# \## Quick Links

# 

# \- \[Project walkthrough](walkthrough/project-walkthrough.md)

# \- \[Final report](reports/ALY6040\_Gun\_Violence\_Final\_Report.pdf)

# \- \[Presentation slides](slides/ALY6040\_Gun\_Violence\_Presentation.pdf)

# \- \[Original R script](scripts/01\_full\_analysis.R)

# \- \[Data note](data/README.md)

# \- \[Data dictionary](data/data-dictionary.md)

# \- \[Contribution note](contribution-note.md)

# \- \[Version note](archive/notes/version-note.md)

# 

# \## Project Background

# 

# This was my Module 6 final project for \*\*ALY6040: Data Mining\*\*. I wanted to understand what patterns show up in gun violence incidents and what factors may be related to more severe cases.

# 

# My original project focused on these questions:

# 

# 1\. What factors predict severe incidents?

# 2\. Are there times of the year when incidents are more likely?

# 3\. Which incidents are more likely to have multiple casualties?

# 4\. How do local factors relate to high incident rates in certain states?

# 

# \## Dataset

# 

# \- \*\*Source:\*\* Kaggle - Gun Violence Data

# \- \*\*Project file used:\*\* `gun-violence-data\_01-2013\_03-2018.csv`

# \- \*\*Time range:\*\* January 2013 to March 2018

# \- \*\*Size used in this project:\*\* 239,677 rows and 29 columns

# \- \*\*Public repo note:\*\* the raw CSV is not included in this repo. See \[data/README.md](data/README.md).

# 

# \## What I Did

# 

# \- cleaned the data and checked missing values, duplicates, and outliers

# \- created time-based features such as year, quarter, month, day, and weekday

# \- analyzed state, city, participant, and incident-characteristic patterns

# \- used word clouds on `location\_description`

# \- created `total\_casualties` and `high\_casualty`

# \- tested several models and used Random Forest as the main final model in the report

# \- wrote the final report and kept the original project materials

# 

# \## Main Findings

# 

# \- incidents increased from 2014 to 2017

# \- Illinois, California, Florida, and Texas had the highest incident counts

# \- Chicago stood out as the top city by incident count

# \- incidents were more frequent on weekends

# \- January, March, and summer months were relatively high

# \- many participants were male, and common ages were around 18 to 26

# \- location words such as apartments, parks, schools, and neighborhoods appeared often

# \- the final Random Forest model had high accuracy but weak recall for high-casualty cases

# 

# \## Model Note

# 

# The final report version of the Random Forest model showed:

# 

# \- Accuracy: 97.45%

# \- Precision: 86.67%

# \- Recall: 2.94%

# \- F1 score: 5.68%

# 

# So I do \*\*not\*\* present this as a strong finished prediction product. I present it as a strong end-to-end analysis project with an honest model limitation.

# 

# \## Important Note on Source Files

# 

# This repo keeps the final report, the original R script, selected figures, and the original slide deck.

# 

# For the public summary, I follow the \*\*final report\*\* and the \*\*main R workflow\*\*. The slide deck is kept as an original class deliverable, and some modeling slides reflect an earlier or alternate experiment version. I added a short note here:

# 

# \- \[archive/notes/version-note.md](archive/notes/version-note.md)

# 

# \## Selected Visuals

# 

# \### Incident Trend

# !\[Incidents by year](outputs/figures/eda/incidents-by-year.jpeg)

# 

# \### State-Level Pattern

# !\[State map](outputs/figures/eda/state-map.jpeg)

# 

# \### Participant Gender

# !\[Participant gender](outputs/figures/participants/participant-gender.jpeg)

# 

# \### Location Word Cloud

# !\[Word cloud](outputs/figures/text-mining/wordcloud-frequency.jpeg)

# 

# \## Repo Structure

# 

# \- `walkthrough/` - main public guide for the project

# \- `scripts/` - original R analysis script and package note

# \- `outputs/` - renamed figures used in the public repo

# \- `reports/` - final report PDF

# \- `slides/` - original course slide deck

# \- `archive/` - supporting source materials and version notes

# \- `data/` - data note and data dictionary only

# 

# \## Contribution

# 

# This was an \*\*individual course project\*\*. I completed the analysis, report, and modeling on my own.

# 

# I also reviewed Kaggle notebooks and discussion posts for ideas on data cleaning and handling complex fields, but the work in this repo is my own course project output.

# 

# See \[contribution-note.md](contribution-note.md) for a short note.

# 

# \## Reading Order

# 

# If you are visiting this repo for the first time, I recommend this order:

# 

# 1\. \[Project walkthrough](walkthrough/project-walkthrough.md)

# 2\. \[Final report](reports/ALY6040\_Gun\_Violence\_Final\_Report.pdf)

# 3\. \[Original R script](scripts/01\_full\_analysis.R)

# 4\. \[Slides](slides/ALY6040\_Gun\_Violence\_Presentation.pdf)

