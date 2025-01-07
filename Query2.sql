Query2
/**2. How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?**/

WITH MonthlyScannedReceipts AS (
    SELECT 
        p.brandCode,
        EXTRACT(MONTH FROM r.dateScanned) AS scanMonth,
        EXTRACT(YEAR FROM r.dateScanned) AS scanYear,
        COUNT(DISTINCT r.receiptId) AS receiptsScanned
    FROM 
        Receipts r
    INNER JOIN 
        PurchasedItems p ON r.receiptId = p.receiptId
    WHERE 
        r.dateScanned >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '2 months'
    GROUP BY 
        p.brandId, scanYear, scanMonth
),
RankedReceipts AS (
    SELECT 
        *,
        RANK() OVER (PARTITION BY scanYear, scanMonth ORDER BY receiptsScanned DESC) AS rank
    FROM 
        MonthlyScannedReceipts
    WHERE 
        scanMonth IN (EXTRACT(MONTH FROM CURRENT_DATE) - 1, EXTRACT(MONTH FROM CURRENT_DATE) - 2)
)
SELECT 
    b.name AS brandName,
    scanMonth,
    rank AS brandRank,
    receiptsScanned
FROM 
    RankedReceipts rr
INNER JOIN 
    Brands b ON rr.brandId = b.brandId
WHERE 
    rank <= 5
ORDER BY 
    scanMonth, rank;
