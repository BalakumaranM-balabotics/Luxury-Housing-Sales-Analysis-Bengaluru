SELECT
    Developer_Name,
    AVG(Ticket_Price_Cr) AS avg_ticket_price
FROM luxury_housing_final
GROUP BY Developer_Name
ORDER BY avg_ticket_price DESC;