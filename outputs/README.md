# Outputs Folder

This folder keeps selected project outputs that are useful for GitHub visitors and interview review.

## Folder Structure

- [`figures/selected/`](figures/selected/) - selected charts used in the README and walkthrough

The original course project created more charts than the selected set shown here. For the public portfolio version, I kept the visuals that explain the project story most clearly.

## What I Kept in `figures/selected/`

The selected folder includes charts for:

- yearly incident trend
- monthly incident trend
- weekday pattern
- incidents by quarter and year
- top states by raw incident count
- top cities by raw incident count
- U.S. state map by raw incident count
- participant status
- participant type
- participant age
- participant gender
- incident characteristics
- outliers in `n_killed` and `n_injured`
- relationship between killed and injured counts
- location-description word clouds
- model evaluation artifacts from the original work

## Recommended Visuals for the Public Story

For the README or interview slides, the clearest visuals are:

- `number-of-incidents-by-year-2013-2018.jpeg`
- `incidents-by-weekday.jpeg`
- `top-states-by-incident-frequency.jpeg`
- `top-10-cities-by-number-of-incidents.jpeg`
- `distribution-of-participant-statuses.jpeg`
- `top-10-most-common-participant-ages.jpeg`
- `gender-distribution-of-participants.jpeg`
- `wordcloud-1.jpeg`

The state and city charts show raw incident counts, not per-capita risk.

## Important Note About Model Evaluation Visuals

Some model evaluation visuals come from the original course materials and may not fully match the final conservative model interpretation used in the public README.

For public portfolio use, the safest model reference is:

- Accuracy: 97.45%
- Precision: 86.67%
- Recall: 2.94%
- F1 Score: 5.68%

Because recall is very weak, the model should be described as a coursework classification experiment rather than a reliable high-casualty prediction system.
