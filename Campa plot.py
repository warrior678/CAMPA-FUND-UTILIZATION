import pandas as pd
import matplotlib.pyplot as plt
import numpy as np


data = pd.DataFrame({
    "State": ["Andaman and Nicobar", "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar"],
    "Fund_2019_20": [0.01, 99.17, 166.20, 32.02, 125.39],
    "Fund_2020_21": [0.17, 59.56, 0.00, 22.28, 183.20]
})


states = data["State"]
x = np.arange(len(states))  
width = 0.35                

fig, ax = plt.subplots(figsize=(11, 6))
bars1 = ax.bar(x - width/2, data["Fund_2019_20"], width, label='2019-20')
bars2 = ax.bar(x + width/2, data["Fund_2020_21"], width, label='2020-21')


ax.set_title("State-wise CAMPA Fund Allocation (2019–20 vs 2020–21)", fontsize=14)
ax.set_xlabel("State")
ax.set_ylabel("Fund (₹ Cr)")
ax.set_xticks(x)
ax.set_xticklabels(states, rotation=30, ha='right')
ax.legend(title="Financial Year")


def annotate_bars(bars):
    for bar in bars:
        height = bar.get_height()
        ax.annotate(f'{height:.2f}',
                    xy=(bar.get_x() + bar.get_width() / 2, height),
                    xytext=(0, 4),
                    textcoords="offset points",
                    ha='center', va='bottom', fontsize=8)

annotate_bars(bars1)
annotate_bars(bars2)


plt.tight_layout()
plt.show() 

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np


file_path = "CAMPA FUND UTILIZATION.xlsx"
df = pd.read_excel(file_path)


print("Columns in file:", df.columns.tolist())
print(df.head())


df = df.rename(columns={
    df.columns[0]: "State",
    df.columns[1]: "Fund_2019_20",
    df.columns[2]: "Fund_2020_21"
})


df = df.dropna(subset=["State"])


states = df["State"]
x = np.arange(len(states))
width = 0.35


fig, ax = plt.subplots(figsize=(12, 6))
bars1 = ax.bar(x - width/2, df["Fund_2019_20"], width, label='2019-20')
bars2 = ax.bar(x + width/2, df["Fund_2020_21"], width, label='2020-21')


ax.set_title("State-wise CAMPA Fund Allocation (2019–20 vs 2020–21)", fontsize=14)
ax.set_xlabel("State")
ax.set_ylabel("Fund (₹ Cr)")
ax.set_xticks(x)
ax.set_xticklabels(states, rotation=45, ha='right')
ax.legend(title="Financial Year")

def annotate_bars(bars):
    for bar in bars:
        height = bar.get_height()
        ax.annotate(f'{height:.2f}',
                    xy=(bar.get_x() + bar.get_width() / 2, height),
                    xytext=(0, 4),
                    textcoords="offset points",
                    ha='center', va='bottom', fontsize=8)

annotate_bars(bars1)
annotate_bars(bars2)

plt.tight_layout()
plt.show()

