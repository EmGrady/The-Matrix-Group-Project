-- Query 4: Products Priced Above Overall Average

SELECT
    ProductName,
    BasePrice
FROM Product
WHERE BasePrice >
(
    SELECT ROUND(AVG(BasePrice), 2)
    FROM Product
)
ORDER BY BasePrice DESC;