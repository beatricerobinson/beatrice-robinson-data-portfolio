# Healthcare Data Analysis with R

## Project Overview

This project analyzes adult asthma prevalence data using R to identify patterns across U.S. states, time periods, sex, race/ethnicity, and age groups.

The project demonstrates an end-to-end healthcare data analytics workflow, including data cleaning, transformation, descriptive analysis, aggregation, and visualization.

## Healthcare Question

How does adult asthma prevalence vary across geographic locations and demographic groups, and how does prevalence change over time?

## Project Objectives

- Clean and prepare healthcare data for analysis
- Examine adult asthma prevalence across U.S. states
- Analyze trends in asthma prevalence over time
- Compare prevalence by sex
- Compare prevalence by race/ethnicity
- Compare prevalence by age group
- Identify geographic and demographic patterns
- Create visualizations to communicate findings
- Develop data-driven insights from healthcare data

## Dataset

The analysis uses publicly available CDC healthcare data focused on **current asthma among adults**.

The dataset includes information such as:

- Location
- Year
- Asthma prevalence
- Sex
- Race/ethnicity
- Age group
- Stratification information

Missing asthma prevalence values were removed before analysis, and prevalence values were converted from text to numeric format for analysis.

## Analysis Performed

### Geographic Analysis

Calculated average adult asthma prevalence across U.S. states and identified states with higher and lower average prevalence.

### Trend Analysis

Examined adult asthma prevalence in the United States across available years to identify changes over time.

### Demographic Analysis

Compared average adult asthma prevalence across:

- Sex
- Race/ethnicity
- Age groups

### Statistical Summaries

Used aggregation and descriptive statistics to calculate average prevalence across geographic and demographic groups.

## Visualizations

The project includes visualizations of:

- Top 10 U.S. states by average adult asthma prevalence
- Adult asthma prevalence over time in the United States
- Adult asthma prevalence by sex
- Adult asthma prevalence by race/ethnicity
- Adult asthma prevalence by age group
- Average adult asthma prevalence by U.S. state

## Tools & Technologies

- **R**
- **RStudio**
- **Base R**
- **dplyr**
- **tidyverse**
- **ggplot2**
- **readr**
- Data cleaning and transformation
- Exploratory data analysis
- Descriptive statistics
- Data visualization

## Skills Demonstrated

This project demonstrates experience with:

- Healthcare data analysis
- Data cleaning
- Data transformation
- Exploratory data analysis (EDA)
- Descriptive statistics
- Aggregation
- Geographic analysis
- Demographic analysis
- Trend analysis
- Data visualization
- Communicating data-driven insights
- Reproducible analytical workflows

## Project Structure

```text
healthcare-data-analysis/
│
├── figures/
│   ├── top_10_asthma_states.png
│   ├── us_asthma_trend.png
│   ├── asthma_by_sex.png
│   ├── asthma_by_race.png
│   └── asthma_by_age.png
│
├── analysis.R
├── analysis_clean.R
├── healthcare-data-analysis.Rproj
├── asthma_age_summary.csv
├── asthma_race_summary.csv
├── asthma_sex_summary.csv
├── asthma_trend_summary.csv
├── state_asthma_summary.csv
└── README.md
