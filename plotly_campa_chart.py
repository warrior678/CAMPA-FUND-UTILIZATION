
import pandas as pd
import plotly.express as px

# Step 1: Create the dataset
data = pd.DataFrame({
    "State": ["Andaman and Nicobar", "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar"],
    "Fund_2019_20": [0.01, 99.17, 166.20, 32.02, 125.39],
    "Fund_2020_21": [0.17, 59.56, 0.00, 22.28, 183.20]
})

# Step 2: Reshape the data for visualization
data_melted = data.melt(id_vars="State", var_name="Year", value_name="Fund")

# Step 3: Create the grouped bar chart
fig = px.bar(
    data_melted,
    x="State",
    y="Fund",
    color="Year",
    barmode="group",
    title="State-wise CAMPA Fund Allocation (2019–20 vs 2020–21)",
    text="Fund"
)

# Step 4: Beautify chart layout
fig.update_layout(
    xaxis_title="State",
    yaxis_title="Fund (₹ Cr)",
    legend_title="Financial Year"
)

fig.update_traces(texttemplate='%{text:.2f}', textposition='outside')

# Step 5: Display the chart
fig.show()
