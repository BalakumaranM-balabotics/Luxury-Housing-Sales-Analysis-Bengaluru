SELECT
    Quarter_Number,
    COUNT(*) AS total_records
FROM luxury_housing_final
GROUP BY Quarter_Number
ORDER BY Quarter_Number;