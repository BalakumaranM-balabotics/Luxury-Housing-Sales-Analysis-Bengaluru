USE luxury_housing_details_blr;
SELECT
    Booking_Flag,
    COUNT(*) AS total_records
FROM luxury_housing_final
GROUP BY Booking_Flag
ORDER BY Booking_Flag;
