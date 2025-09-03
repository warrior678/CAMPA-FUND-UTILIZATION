import pandas as pd
import matplotlib.pyplot as plt


file_path = "CAMPA FUND UTILIZATION.xlsx"
df = pd.read_excel(file_path)


df.columns = df.columns.map(str)


state_col = df.columns[0]


fund_2020_col = df.columns[-1]  

fund_2019_col = df.columns[1] if len(df.columns) > 2 else None

print("Detected columns:", state_col, fund_2019_col, fund_2020_col)

# --- Step 3: Rename for clarity ---
rename_map = {state_col: "State", fund_2020_col: "Fund_2020_21"}
if fund_2019_col:
    rename_map[fund_2019_col] = "Fund_2019_20"

df = df.rename(columns=rename_map)

df = df.dropna(subset=["State"])


top10 = df.sort_values("Fund_2020_21", ascending=False).head(10)

# --- Step 5: Plot chart ---
plt.figure(figsize=(10,6))
plt.barh(top10["State"], top10["Fund_2020_21"], color="skyblue")
plt.xlabel("Fund (₹ Cr)")
plt.ylabel("State")
plt.title("Top 10 States by CAMPA Fund Utilization (2020–21)")
plt.gca().invert_yaxis()
plt.tight_layout()
plt.show()
