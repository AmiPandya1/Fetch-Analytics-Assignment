Query1
/**1. What are the top 5 brands by receipts scanned for the most recent month?**/


WITH RecentMonth AS (
    SELECT 
        p.brandCode,
        COUNT(DISTINCT r.receiptId) AS receiptsScanned
    FROM 
        Receipts r
    INNER JOIN 
        PurchasedItems p ON r.receiptId = p.receiptId
    WHERE 
        r.dateScanned >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'
    GROUP BY 
        p.brandId
)
SELECT 
    b.name AS brandName,
    rm.receiptsScanned
FROM 
    RecentMonth rm
INNER JOIN 
    Brands b ON rm.brandCode = b.brandCode
ORDER BY 
    rm.receiptsScanned DESC
LIMIT 5;
