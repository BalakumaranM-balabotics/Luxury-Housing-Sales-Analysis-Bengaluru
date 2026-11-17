USE luxury_housing_details_blr;
SELECT
    COUNT(*) AS total_rows,
    SUM(Ticket_Price_Cr IS NULL) AS missing_ticket_price,
    SUM(Unit_Size_Sqft IS NULL) AS missing_unit_size,
    SUM(Amenity_Score IS NULL) AS missing_amenity_score,
    SUM(Price_per_Sqft IS NULL) AS missing_price_per_sqft
FROM luxury_housing_final;


USE luxury_housing_details_blr;
SELECT
    Transaction_Type,
    COUNT(*) AS total_transactions
FROM luxury_housing_final
GROUP BY Transaction_Type;


USE luxury_housing_details_blr;
SELECT
    Booking_Flag,
    COUNT(*) AS total_records
FROM luxury_housing_final
GROUP BY Booking_Flag
ORDER BY Booking_Flag;


SELECT
    Quarter_Number,
    COUNT(*) AS total_records
FROM luxury_housing_final
GROUP BY Quarter_Number
ORDER BY Quarter_Number;


SELECT COUNT(DISTINCT Developer_Name) AS total_builders
FROM luxury_housing_final;


SELECT COUNT(DISTINCT Micro_Market) AS total_micro_markets
FROM luxury_housing_final;


SELECT COUNT(DISTINCT Project_Name) AS total_projects
FROM luxury_housing_final;


SELECT
    MIN(Ticket_Price_Cr) AS min_ticket_price,
    MAX(Ticket_Price_Cr) AS max_ticket_price,
    AVG(Ticket_Price_Cr) AS avg_ticket_price
FROM luxury_housing_final;


SELECT
    Developer_Name,
    AVG(Ticket_Price_Cr) AS avg_ticket_price
FROM luxury_housing_final
GROUP BY Developer_Name
ORDER BY avg_ticket_price DESC;