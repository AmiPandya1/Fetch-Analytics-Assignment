Query3

/** 3.When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?**/


SELECT 
    rewardsReceiptStatus,
    AVG(totalSpent) AS averageSpend
FROM 
    Receipts
WHERE 
    rewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY 
    rewardsReceiptStatus
ORDER BY 
    averageSpend DESC;