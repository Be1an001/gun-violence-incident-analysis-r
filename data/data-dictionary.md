# Data Dictionary

This is a simple working dictionary based on the CSV used in this project.

I did not include a separate official codebook in this repo, so the notes below are based on the column names and how I used them in the project.

## Incident Details

- `incident_id` - unique incident ID
- `date` - incident date
- `state` - U.S. state name
- `city_or_county` - city or county name
- `address` - incident address text
- `incident_url` - incident page URL
- `source_url` - source article or source URL
- `incident_url_fields_missing` - indicator related to missing incident URL fields
- `notes` - free-text notes about the incident
- `sources` - source text or source list

## Outcome and Severity

- `n_killed` - number of people killed
- `n_injured` - number of people injured
- `n_guns_involved` - number of guns involved

## Location and Geography

- `congressional_district` - congressional district
- `state_house_district` - state house district
- `state_senate_district` - state senate district
- `latitude` - latitude
- `longitude` - longitude
- `location_description` - text description of the location

## Gun Information

- `gun_stolen` - text related to whether guns were stolen
- `gun_type` - gun type text
- `incident_characteristics` - text tags describing incident characteristics

## Participant Information

- `participant_age` - participant age text field
- `participant_age_group` - participant age group text field
- `participant_gender` - participant gender text field
- `participant_name` - participant name text field
- `participant_relationship` - relationship text field
- `participant_status` - participant status text field
- `participant_type` - participant type text field

## Project-Specific Derived Fields

These were created during the project workflow and are not part of the raw CSV:

- `year` - extracted from `date`
- `quarter` - extracted from `date`
- `month` - extracted from `date`
- `day` - extracted from `date`
- `weekday` - extracted from `date`
- `date2` - combined display field for year, month, and day
- `total_casualties` - `n_killed + n_injured`
- `high_casualty` - binary field for incidents with 3 or more total casualties