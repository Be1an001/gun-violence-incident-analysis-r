# Data Note

This public repo is not meant to redistribute the raw project CSV.

A local copy can be placed in `data/raw/` for reproduction. That folder is ignored by Git so the large source file does not become part of the public portfolio repository.

## Main File Used in the Original Project

- **Filename:** `gun-violence-data_01-2013_03-2018.csv`
- **Source:** [Gun Violence Data on Kaggle](https://www.kaggle.com/datasets/jameslko/gun-violence-data)
- **Time range in the project file:** January 2013 to March 2018
- **Rows / columns used in this project:** 239,677 rows and 29 columns

## Why the Raw Data Is Not in This Repo

I keep the raw CSV out of the public repo for three reasons:

1. the original file is large and not good for a clean public GitHub repo
2. I want the repo to stay easy to clone and easy to read
3. the source page should be checked directly before redistributing the original data file publicly

## How to Reproduce the Project

1. Download the dataset from the Kaggle source page above.
2. Save the file locally as:

   `data/raw/gun-violence-data_01-2013_03-2018.csv`

3. Open `scripts/01_full_analysis.R`.
4. Make sure the file path points to the file above.

The script checks both `data/raw/` and `../data/raw/`, so it can run from the repository root or from inside the `scripts/` folder.

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

## Documentation Note

The project uses raw incident counts for state and city visuals. Those charts should not be interpreted as per-capita risk comparisons unless population data is added later.
