# ============================================================
# Adult Asthma Prevalence Analysis
# CDC Chronic Disease Indicators
#
# Author: Beatrice Robinson
# Purpose: Explore patterns in adult asthma prevalence
# across U.S. states, time, sex, race/ethnicity, and age.
# ============================================================


# ============================================================
# 1. Load Data
# ============================================================

cdc_data <- read.csv(
  "data/U.S._Chronic_Disease_Indicators_20260917.csv",
  stringsAsFactors = FALSE
)


# ============================================================
# 2. Prepare Adult Asthma Data
# ============================================================

asthma_data <- subset(
  cdc_data,
  Topic == "Asthma" &
    Question == "Current asthma among adults"
)

# Convert prevalence values to numeric
asthma_data$DataValueNumeric <- as.numeric(
  asthma_data$DataValue
)

# Remove records with missing prevalence values
asthma_clean <- asthma_data[
  !is.na(asthma_data$DataValueNumeric),
]


# ============================================================
# 3. State-Level Analysis
# ============================================================

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

state_only <- subset(
  asthma_clean,
  LocationDesc %in% us_states
)

state_summary <- aggregate(
  DataValueNumeric ~ LocationDesc,
  data = state_only,
  FUN = mean
)

state_summary <- state_summary[
  order(-state_summary$DataValueNumeric),
]


# ============================================================
# 4. U.S. Trend Analysis
# ============================================================

asthma_overall <- subset(
  asthma_clean,
  StratificationCategory1 == "Overall" &
    Stratification1 == "Overall" &
    LocationDesc == "United States"
)

asthma_by_year <- aggregate(
  DataValueNumeric ~ YearStart,
  data = asthma_overall,
  FUN = mean,
  na.rm = TRUE
)

asthma_by_year <- asthma_by_year[
  order(asthma_by_year$YearStart),
]


# ============================================================
# 5. Sex Analysis
# ============================================================

asthma_by_sex <- subset(
  asthma_clean,
  StratificationCategory1 == "Sex"
)

sex_summary <- aggregate(
  DataValueNumeric ~ Stratification1,
  data = asthma_by_sex,
  FUN = mean,
  na.rm = TRUE
)


# ============================================================
# 6. Race/Ethnicity Analysis
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

race_summary <- race_summary[
  order(-race_summary$DataValueNumeric),
]


# ============================================================
# 7. Age Analysis
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

age_summary <- age_summary[
  order(-age_summary$DataValueNumeric),
]


# ============================================================
# 8. Save Analysis Results
# ============================================================

write.csv(
  state_summary,
  "state_asthma_summary.csv",
  row.names = FALSE
)

write.csv(
  asthma_by_year,
  "asthma_trend_summary.csv",
  row.names = FALSE
)

write.csv(
  sex_summary,
  "asthma_sex_summary.csv",
  row.names = FALSE
)

write.csv(
  race_summary,
  "asthma_race_summary.csv",
  row.names = FALSE
)

write.csv(
  age_summary,
  "asthma_age_summary.csv",
  row.names = FALSE
)