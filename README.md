# Luxury Housing Sales Analysis – Bengaluru
**End-to-End Real Estate Analytics Project**

---

## Tech Stack

![Python](https://img.shields.io/badge/Python-Programming-3776AB?style=flat&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-150458?style=flat&logo=pandas&logoColor=white)
![NumPy](https://img.shields.io/badge/NumPy-Numerical%20Computing-013243?style=flat&logo=numpy&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-Database-4479A1?style=flat&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=flat&logo=powerbi&logoColor=black)
![VS Code](https://img.shields.io/badge/VS%20Code-Editor-007ACC?style=flat&logo=visualstudiocode&logoColor=white)

---

## Project Overview

This project analyses the luxury housing market in Bengaluru using a property-level dataset of **100,000 records**. The goal is to turn raw real-estate transaction data into a clean analytical dataset, store it in MySQL, and use Power BI to explore market patterns and answer business questions.

The project follows an end-to-end analytics workflow:

**Raw Data → Exploratory Data Analysis → Data Cleaning → Feature Engineering → MySQL Integration → Data Validation → Power BI Dashboard → Business Insights**

The analysis focuses on:
- Pricing patterns and price-per-square-foot comparisons
- Demand across Bengaluru micro-markets
- Builder/developer performance
- Configuration preferences
- Quarterly patterns
- Sales-channel and possession-status comparisons

---

## Core Business Questions

The Power BI dashboard is designed around the ten questions in the project brief:

1. **Market Trends:** How have housing transactions changed quarter by quarter across micro-markets?
2. **Builder Performance:** Which developers have the highest total ticket sales and how do they rank by average ticket price?
3. **Amenity Impact:** How does amenity score relate to the booking indicator used in this dataset?
4. **Booking Conversion:** Which micro-markets have the highest and lowest values for the booking indicator/rate?
5. **Configuration Demand:** Which configurations (3BHK, 4BHK and 5BHK+) are most common?
6. **Sales Channel Efficiency:** How do transaction indicators vary across sales channels?
7. **Quarterly Builder Contribution:** Which developers contribute the most ticket value in each quarter?
8. **Possession Status Analysis:** How do possession status and buyer type relate to the transaction indicator?
9. **Geographical Insights:** Where are the records concentrated across Bengaluru micro-markets?
10. **Top Performers:** Which five developers lead in ticket value and the available transaction indicator?

---

## Dataset Summary

- **City:** Bengaluru, Karnataka, India
- **Domain:** Luxury residential real estate
- **Granularity:** Property-level records
- **Final dataset size:** 100,000 rows × 22 columns
- **Original fields:** 18
- **Engineered fields:** 4

### Main dataset fields

| Area | Columns |
|---|---|
| Property and location | `Property_ID`, `Micro_Market`, `Project_Name` |
| Developer and property details | `Developer_Name`, `Configuration`, `Unit_Size_Sqft` |
| Pricing | `Ticket_Price_Cr`, `Price_per_Sqft` |
| Transaction and buyer | `Transaction_Type`, `Buyer_Type`, `NRI_Buyer` |
| Time and project status | `Purchase_Quarter`, `Quarter_Number`, `Possession_Status` |
| Location and facilities indicators | `Connectivity_Score`, `Amenity_Score`, `Locality_Infra_Score`, `Avg_Traffic_Time_Min` |
| Sales and comments | `Sales_Channel`, `Buyer_Comments` |
| Engineered helper fields | `Booking_Flag`, `Booking_Conversion_Helper` |

---

## Python: EDA, Data Cleaning & Feature Engineering

Python was used to inspect the raw dataset, identify quality issues, clean inconsistent values, and create additional analytical fields.

### Exploratory Data Analysis (EDA)

- Inspected dataset shape, columns, data types and descriptive statistics.
- Reviewed missing values and their percentages.
- Checked duplicate property identifiers.
- Examined category distributions and inconsistent text labels.
- Inspected numerical ranges and mixed-format ticket-price values.

### Data Cleaning

- Removed duplicate `Property_ID` records, reducing the dataset from 101,000 rows to 100,000 rows.
- Standardised `Micro_Market` text values and capitalization.
- Standardised `Configuration` values into `3BHK`, `4BHK` and `5BHK+` categories.
- Cleaned mixed `Ticket_Price_Cr` formats, including currency symbols (`₹`) and the `Cr` suffix, and converted the column to numeric form.
- Treated negative ticket prices as invalid values; missing ticket prices were handled using mean imputation in line with the project guidance.
- Replaced invalid negative `Unit_Size_Sqft` values with missing values, then imputed missing unit sizes using the median for the corresponding configuration.
- Filled missing `Amenity_Score` values using the column median.
- Replaced missing buyer comments with `data_not_provided`.
- Converted date and numerical columns to appropriate data types for analysis and database loading.

### Feature Engineering

Four additional fields were created:

| Feature | Purpose |
|---|---|
| `Price_per_Sqft` | Calculates ticket price in rupees divided by unit size in square feet. |
| `Quarter_Number` | Extracts the calendar quarter (1–4) from `Purchase_Quarter`. |
| `Booking_Flag` | Encodes `Primary` as 1 and `Secondary` as 0, following the chosen transaction-type mapping. |
| `Booking_Conversion_Helper` | Assigns 1 to each row so the total record count can be used as a denominator in a rate calculation. |

The final feature-engineered dataset contains **22 columns** and was exported for database loading and reporting.

---

## MySQL: Database Integration & Validation

MySQL was used as the relational data store for the final analytical dataset.

- **Database:** `luxury_housing_details_blr`
- **Table:** `luxury_housing_final`
- **Final table size:** 100,000 rows × 22 columns
- **Python connector:** `mysql-connector-python` (`mysql.connector`)

The final DataFrame was prepared for SQL insertion by converting pandas missing values to Python `None`, which MySQL stores as SQL `NULL`. The records were inserted in batches of 5,000 rows using `cursor.executemany()` and committed batch by batch.

Basic validation was performed in MySQL to confirm row counts, missing values, transaction-type distribution, booking-flag distribution and quarter distribution.

---

## Dashboard Scope (Power BI)

Power BI is used to present the ten business questions through interactive visuals, KPI cards, slicers and DAX measures. The planned report is organised into four pages so the visuals remain readable.

### Common slicers

- Quarter (`Quarter_Number`)
- Micro Market (`Micro_Market`)
- Builder Name (`Developer_Name`)
- Configuration (`Configuration`)
- Sales Channel (`Sales_Channel`)

### Page 1 — Market & Builder Overview

- Q1: Market Trends — line chart of the transaction/booking indicator by quarter and micro-market
- Q2: Builder Performance — comparison of total ticket sales and average ticket price by developer
- Q3: Amenity Impact — scatter chart comparing amenity score with the available booking indicator/rate

### Page 2 — Booking & Demand

- Q4: Booking Conversion — comparison of the booking indicator/rate across micro-markets
- Q5: Configuration Demand — donut chart of configurations by transaction/booking indicator
- Q6: Sales Channel Efficiency — 100% stacked column chart by sales channel and transaction indicator

### Page 3 — Quarterly & Location Analysis

- Q7: Quarterly Builder Contribution — matrix of developer by quarter using total ticket price
- Q8: Possession Status Analysis — clustered column chart comparing possession status and buyer type
- Q9: Geographical Insights — map or location visual based on micro-market

### Page 4 — Top Performers

- Q10: Top Performers — top five developers by ticket value, with the available transaction indicator and a supporting detail table

### DAX

Two DAX measures are planned for the report to support booking-indicator/rate analysis and dashboard KPIs. Measures will be labelled according to what the available dataset can genuinely support; see **Assumptions & Limitations** below.

---

## Analytical Principles

### Data Integrity
- Preserve the raw dataset separately from cleaned and feature-engineered versions.
- Apply explicit cleaning and validation steps before database loading.
- Keep missing, invalid and imputed values conceptually distinct.
- Verify row counts and key column distributions after loading.

### Metric Design
- Use `SUM(Ticket_Price_Cr)` for total ticket value and `AVERAGE(Ticket_Price_Cr)` for average ticket price.
- Use an average, rather than a sum, when comparing `Price_per_Sqft` across groups.
- Use the quarter and micro-market fields as analysis dimensions.
- Clearly label any metric that is a proxy rather than a directly observed business outcome.

### Market Analysis
- Compare market concentration by micro-market.
- Examine developer and configuration patterns.
- Compare ticket value across quarters and sales channels.
- Use charts and slicers to help users explore the data by market, builder, quarter, configuration and channel.

---

## Project Folder Structure

The following is a suggested repository layout. Update file and folder names to match the actual files you add to GitHub.

```text
Luxury-Housing-Sales-Analysis-Bengaluru/
├── data/
│   ├── raw/
│   │   └── Luxury_Housing_Bangalore.csv
│   ├── processed/
│   │   ├── Luxury_Housing_Cleaned.xlsx
│   │   └── Luxury_Housing_Final.csv
│   └── exports/
│       └── luxury_housing_final_powerbi.csv
│
├── notebooks/
│   ├── 01_eda.ipynb
│   ├── 02_data_cleaning.ipynb
│   └── 03_feature_engineering.ipynb
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_table.sql
│   └── 03_data_validation.sql
│
├── power_bi/
│   └── Luxury_Housing_Sales_Analysis.pbix
│
├── screenshots/
│   └── dashboard_screenshots/
│
└── README.md
```

**Data note:** Do not commit passwords, connection strings containing credentials, or other secrets. Check the dataset's sharing/licensing conditions before publishing the raw data; large CSV/XLSX files can also be kept outside GitHub and linked or documented separately.

---

## Key Deliverables

- **Python notebooks:** EDA, data cleaning and feature engineering
- **Processed dataset:** cleaned and feature-engineered 100,000-row dataset
- **MySQL database:** `luxury_housing_details_blr` with the `luxury_housing_final` table
- **SQL validation:** checks for row counts, missing values and key categorical distributions
- **Power BI report:** interactive analysis of the ten project questions
- **DAX measures:** measures for KPI and booking-indicator/rate calculations
- **Project documentation:** workflow, methodology, assumptions, limitations and dashboard screenshots

---

## Assumptions & Limitations

- The available dataset contains `Transaction_Type` (`Primary` / `Secondary`) rather than a separate, independently observed `Booking_Status` field.
- `Booking_Flag` is derived by mapping `Primary` to 1 and `Secondary` to 0. It is therefore a **transaction-type proxy**, not proof that a transaction was a successful booking.
- `Booking_Conversion_Helper` is 1 for every row. A rate calculated as `SUM(Booking_Flag) / SUM(Booking_Conversion_Helper)` represents the share of records classified as `Primary` under this mapping. It should not be described as a true inquiry-to-booking conversion rate.
- The dataset does not include inquiry-level or lead-funnel records, so enquiry-to-booking conversion and sales drop-offs cannot be measured directly.
- Mean-imputed ticket prices and median-imputed unit sizes/amenity scores are estimates; analyses involving these fields should be interpreted with that in mind.
- The geographical analysis uses `Micro_Market` names. No latitude/longitude fields were available in the described dataset, so map placement depends on Power BI's location recognition and may be approximate.
- The analysis is descriptive and diagnostic; it is not a predictive model.

These limitations should be reflected in chart titles, KPI labels and business conclusions.

---

## Intended Audience

This project is intended for:
- Recruiters and hiring managers reviewing practical analytics skills
- Data analytics and business intelligence learners
- Real-estate teams interested in pricing and market structure
- Academic project reviewers evaluating an end-to-end analytics workflow

---

## Final Note

This project demonstrates an end-to-end analytics workflow: examining raw data, improving data quality, engineering useful fields, storing the prepared dataset in MySQL, and presenting market analysis in Power BI.

The goal is not simply to create charts, but to make the assumptions behind each metric clear and turn the available data into useful, responsible business insights.

**Author:** [Balakumaran M]  
**Domain:** Data Analytics | Real Estate | Business Intelligence
