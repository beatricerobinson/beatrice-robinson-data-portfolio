list.files("data")
# ============================================================
# Healthcare Data Analysis with R
# Author: Beatrice Robinson
# ============================================================

# Check files in the data folder
list.files("data")

# Load the CDC Chronic Disease Indicators dataset
cdc_data <- read.csv(
  "data/U.S._Chronic_Disease_Indicators_20260917.csv",
  stringsAsFactors = FALSE
)
cdc_data <- read.csv(...)

# View column names
names(cdc_data)
# View the first six rows=
head(cdc_data)
# Examine the structure of the dataset
str(cdc_data)
# ============================================================
# Explore available healthcare topics
# ============================================================

unique(cdc_data$Topic)
# View the different healthcare questions
unique(cdc_data$Question)
# Count asthma records
sum(cdc_data$Topic == "Asthma", na.rm = TRUE)
# See the asthma questions
unique(cdc_data$Question[cdc_data$Topic == "Asthma"])
# Create a dataset containing adult asthma prevalence records
asthma_data <- subset(
  cdc_data,
  Topic == "Asthma" &
    Question == "Current asthma among adults"
)
# Check the size of our asthma dataset
dim(asthma_data)

# See how the records are distributed by measurement unit
table(asthma_data$DataValueUnit)  
# Convert DataValue from text to numeric
asthma_data$DataValueNumeric <- as.numeric(asthma_data$DataValue)
# Check the new numeric variable
summary(asthma_data$DataValueNumeric)
# Count missing asthma prevalence values
sum(is.na(asthma_data$DataValueNumeric))
# ============================================================
# Clean the asthma data
# ============================================================

# Remove records where asthma prevalence is missing
asthma_clean <- asthma_data[
  !is.na(asthma_data$DataValueNumeric),
]

# Check the number of usable records
dim(asthma_clean)
# Count records by state
table(asthma_clean$LocationDesc)
# ============================================================
# Calculate average adult asthma prevalence by location
# ============================================================

asthma_by_state <- aggregate(
  DataValueNumeric ~ LocationDesc,
  data = asthma_clean,
  FUN = mean
)

# View the results
asthma_by_state
# Sort locations from highest to lowest average prevalence
asthma_by_state <- asthma_by_state[
  order(-asthma_by_state$DataValueNumeric),
]

# View sorted results
asthma_by_state
# Keep U.S. states and Washington, D.C.
state_data <- asthma_clean[
  asthma_clean$LocationDesc %in% c(
    state.name,
    "District of Columbia"
  ),
]

# Check the locations
unique(state_data$LocationDesc)
# Calculate average adult asthma prevalence by state
asthma_by_state <- aggregate(
  DataValueNumeric ~ LocationDesc,
  data = state_data,
  FUN = mean
)

# Sort from highest to lowest
asthma_by_state <- asthma_by_state[
  order(-asthma_by_state$DataValueNumeric),
]

# View results
asthma_by_state
# ============================================================
# Create a bar chart of adult asthma prevalence by state
# ============================================================

# Order state names by prevalence
asthma_by_state$LocationDesc <- reorder(
  asthma_by_state$LocationDesc,
  asthma_by_state$DataValueNumeric
)

# Create horizontal bar chart
barplot(
  asthma_by_state$DataValueNumeric,
  names.arg = asthma_by_state$LocationDesc,
  horiz = TRUE,
  las = 1,
  cex.names = 0.6,
  main = "Average Adult Asthma Prevalence by U.S. State",
  xlab = "Average Prevalence (%)"
)
# ============================================================
# Top 10 U.S. states by average adult asthma prevalence
# ============================================================

top_10_states <- head(state_summary, 10)

png(
  "figures/top_10_asthma_states.png",
  width = 1200,
  height = 800
)

barplot(
  top_10_states$DataValueNumeric,
  names.arg = top_10_states$LocationDesc,
  horiz = TRUE,
  las = 1,
  cex.names = 0.8,
  main = "Top 10 U.S. States by Average Adult Asthma Prevalence",
  xlab = "Average Prevalence (%)"
)

dev.off()
# ============================================================
# Examine how asthma records are stratified
# ============================================================

table(asthma_clean$StratificationCategory1)

table(asthma_clean$Stratification1)
# ============================================================
# Adult asthma prevalence over time - United States
# ============================================================

# Keep only the overall U.S. population
asthma_overall <- subset(
  asthma_clean,
  StratificationCategory1 == "Overall" &
    Stratification1 == "Overall" &
    LocationDesc == "United States"
)

# View the data
asthma_overall[, c("YearStart", "YearEnd", "LocationDesc",
                   "DataValueNumeric")]
# ============================================================
# Calculate average adult asthma prevalence by year
# ============================================================

asthma_by_year <- aggregate(
  DataValueNumeric ~ YearStart,
  data = asthma_overall,
  FUN = mean,
  na.rm = TRUE
)

# Sort by year
asthma_by_year <- asthma_by_year[
  order(asthma_by_year$YearStart),
]

# View the results
asthma_by_year
# ============================================================
# Create asthma prevalence trend chart
# ============================================================

# Save U.S. asthma trend chart as PNG
png(
  "figures/us_asthma_trend.png",
  width = 1000,
  height = 700
)

plot(
  asthma_by_year$YearStart,
  asthma_by_year$DataValueNumeric,
  type = "o",
  pch = 16,
  main = "Adult Asthma Prevalence in the United States",
  xlab = "Year",
  ylab = "Average Prevalence (%)"
)

dev.off()
# ============================================================
# Adult asthma prevalence by sex
# ============================================================

asthma_by_sex <- subset(
  asthma_clean,
  StratificationCategory1 == "Sex"
)

# Calculate average prevalence by sex
sex_summary <- aggregate(
  DataValueNumeric ~ Stratification1,
  data = asthma_by_sex,
  FUN = mean,
  na.rm = TRUE
)

# View results
sex_summary
# ============================================================
# Create bar chart: adult asthma prevalence by sex
# ============================================================
png(
  "figures/asthma_by_sex.png",
  width = 1000,
  height = 700
)

barplot(
  sex_summary$DataValueNumeric,
  names.arg = sex_summary$Stratification1,
  main = "Average Adult Asthma Prevalence by Sex",
  xlab = "Sex",
  ylab = "Average Prevalence (%)",
  ylim = c(0, 15)
)
dev.off()
# ============================================================
# Adult asthma prevalence by race/ethnicity
# ============================================================

asthma_by_race <- subset(
  asthma_clean,
  StratificationCategory1 == "Race/Ethnicity"
)

race_summary <- aggregate(
  DataValueNumeric ~ Stratification1,
  data = asthma_by_race,
  FUN = mean,
  na.rm = TRUE
)

# Sort from highest to lowest
race_summary <- race_summary[
  order(-race_summary$DataValueNumeric),
]

# View results
race_summary
# ============================================================
# Create bar chart: adult asthma prevalence by race/ethnicity
# ============================================================

# Save race/ethnicity chart as PNG
png(
  "figures/asthma_by_race.png",
  width = 1200,
  height = 800
)

barplot(
  race_summary$DataValueNumeric,
  names.arg = race_summary$Stratification1,
  main = "Average Adult Asthma Prevalence by Race/Ethnicity",
  xlab = "Race/Ethnicity",
  ylab = "Average Prevalence (%)",
  las = 2,
  cex.names = 0.7
)

dev.off()
# ============================================================
# Adult asthma prevalence by age group
# ============================================================

asthma_by_age <- subset(
  asthma_clean,
  StratificationCategory1 == "Age"
)

age_summary <- aggregate(
  DataValueNumeric ~ Stratification1,
  data = asthma_by_age,
  FUN = mean,
  na.rm = TRUE
)

# Sort from highest to lowest
age_summary <- age_summary[
  order(-age_summary$DataValueNumeric),
]

# View results
age_summary

# Save age chart as PNG
png(
  "figures/asthma_by_age.png",
  width = 1000,
  height = 700
)

barplot(
  age_summary$DataValueNumeric,
  names.arg = age_summary$Stratification1,
  main = "Average Adult Asthma Prevalence by Age Group",
  xlab = "Age Group",
  ylab = "Average Prevalence (%)"
)

dev.off()
# ============================================================
# 50-STATE ANALYSIS
# ============================================================

# List of U.S. states
us_states <- c(
  "Alabama", "Alaska", "Arizona", "Arkansas", "California",
  "Colorado", "Connecticut", "Delaware", "Florida", "Georgia",
  "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
  "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
  "Massachusetts", "Michigan", "Minnesota", "Mississippi",
  "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire",
  "New Jersey", "New Mexico", "New York", "North Carolina",
  "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania",
  "Rhode Island", "South Carolina", "South Dakota", "Tennessee",
  "Texas", "Utah", "Vermont", "Virginia", "Washington",
  "West Virginia", "Wisconsin", "Wyoming"
)

# Keep only the 50 states
state_only <- subset(
  asthma_clean,
  LocationDesc %in% us_states
)

# Calculate average prevalence by state
state_summary <- aggregate(
  DataValueNumeric ~ LocationDesc,
  data = state_only,
  FUN = mean
)

# Sort from highest to lowest
state_summary <- state_summary[
  order(-state_summary$DataValueNumeric),
]

# View the results
state_summary