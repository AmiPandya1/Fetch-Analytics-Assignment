import pandas as pd
import numpy as np

# Load datasets
receipts = pd.read_json("receipts.json", lines=True)
users = pd.read_json("users.json", lines=True)
brands = pd.read_json("brands.json", lines=True)

print("******** Below are All Missing values if Any ************")
for df_name, df in [("Receipts", receipts), ("Users", users), ("Brands", brands)]:
    missing = df.isnull().sum()
    missing = missing[missing > 0]
    if not missing.empty:
        print(df_name + " Table has missing values ")
        print(missing)

print("*********** Below are Negative Points earned if Any ********")
if (receipts["totalSpent"] < 0).any():
    print("Receipts have negative totalSpent values.")
if (receipts["purchasedItemCount"] < 0).any():
    print("Receipts have negative purchasedItemCount values.")
if (receipts["pointsEarned"] < 0).any():
    print("Receipts have negative pointsEarned values.")

print("********** Status not in Accepted/Rejected***********")   
distinct_statuses = receipts[~receipts['rewardsReceiptStatus'].isin(['Accepted', 'Rejected'])]['rewardsReceiptStatus'].drop_duplicates()

print(distinct_statuses)





