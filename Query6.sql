Query6
/**6. Which brand has the most transactions among users who were created within the past 6 months?**/

WITH RecentUsers AS (
    SELECT 
        userId
    FROM 
        Users
    WHERE 
        createdDate >= CURRENT_DATE - INTERVAL '6 months'
),
UserReceipts AS (
    SELECT 
        r.receiptId,
        p.brandCode
    FROM 
        Receipts r
    INNER JOIN 
        RecentUsers u ON r.userId = u.userId
    INNER JOIN 
        PurchasedItems p ON r.receiptId = p.receiptId
)
SELECT 
    b.name AS brandName,
    COUNT(DISTINCT ur.receiptId) AS totalTransactions
FROM 
    UserReceipts ur
INNER JOIN 
    Brands b ON ur.brandCode = b.brandCode
GROUP BY 
    b.name
ORDER BY 
    totalTransactions DESC
LIMIT 1;
