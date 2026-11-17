SELECT
    MIN(Ticket_Price_Cr) AS min_ticket_price,
    MAX(Ticket_Price_Cr) AS max_ticket_price,
    AVG(Ticket_Price_Cr) AS avg_ticket_price
FROM luxury_housing_final;