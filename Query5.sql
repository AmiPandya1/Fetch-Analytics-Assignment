Query5

/**5. Which brand has the most spend among users who were created within the past 6 months?
**/


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
        r.totalSpent,
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
    SUM(ur.totalSpent) AS totalSpend
FROM 
    UserReceipts ur
INNER JOIN 
    Brands b ON ur.brandCode = b.brandCode
GROUP BY 
    b.name
ORDER BY 
    totalSpend DESC
LIMIT 1;
