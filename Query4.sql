Query4
/** 4. When considering the total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
**/

SELECT 
    rewardsReceiptStatus,
    SUM(purchasedItemCount) AS totalItemsPurchased
FROM 
    Receipts
WHERE 
    rewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY 
    rewardsReceiptStatus
ORDER BY 
    totalItemsPurchased DESC;