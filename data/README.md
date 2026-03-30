# Data Note

This public repo does **not** include the raw project CSV.

A local copy can still be placed in `data/raw/` for reproduction, but it is not meant as a public redistributed dataset in this repo.

## Main File Used in the Original Project

- **Filename:** `gun-violence-data_01-2013_03-2018.csv`
- **Source:** [Gun Violence Data on Kaggle](https://www.kaggle.com/datasets/jameslko/gun-violence-data)
- **Time range in the project file:** January 2013 to March 2018
- **Rows / columns used in this project:** 239,677 rows and 29 columns

## Why the Raw Data Is Not in This Repo

I left the raw CSV out of the public repo for three reasons:

1. the original file is large and not good for a clean public GitHub repo
2. I want the repo to stay easy to clone and easy to read
3. the source page should be checked directly before redistributing the original data file publicly

## How to Reproduce the Project

1. Download the dataset from the Kaggle source page above.
2. Save the file locally as:

   `data/raw/gun-violence-data_01-2013_03-2018.csv`

3. Open `scripts/01_full_analysis.R`.
4. Make sure the file path points to the file above.

## Version Note

The public Kaggle page may describe the dataset with a different total number of incidents than the exact project file I used.

For this repo, I document the exact file used in the project:

- `gun-violence-data_01-2013_03-2018.csv`
- 239,677 rows
- 29 columns

## Files in This Folder

- `README.md` - data access note
- `data-dictionary.md` - simple working dictionary for the project columns
- `raw/` - local folder for downloaded data; keep this folder out of Git
