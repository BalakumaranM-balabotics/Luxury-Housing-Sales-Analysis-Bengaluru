USE luxury_housing_details_blr;
SELECT
    Transaction_Type,
    COUNT(*) AS total_transactions
FROM luxury_housing_final
GROUP BY Transaction_Type;