## 📊 CAMPA Fund Utilization Analysis (FY 2019–20 & 2020–21)

This project analyzes the allocation and utilization of CAMPA (Compensatory Afforestation Fund Management and Planning Authority) funds across various Indian states over two years. It integrates **Python**, **SQL**, and **Excel**, and is built and tested in **VS Code**. The interactive chart and queries help uncover insights into how effectively states used the allocated environmental funds.

---

## 🛠️ Tools & Technologies Used
- **Python** (`pandas`, `plotly.express`)
- **SQL Server (SSMS)`**
- **Excel** (Pivot tables, cleaning)
- **VS Code** (Development Environment)
- **GitHub** (Version control & project hosting)

---

## 📌 Project Highlights

- 🧼 Data cleaned using Excel and `pandas`
- 📊 SQL queries designed to extract key insights
- 📈 Plotly interactive chart for state-level comparison
- ✅ Total of **21 SQL queries** divided into Easy, Medium, Hard
- 🌐 Hosted interactive chart using GitHub Pages

---

## 🌐 Interactive Chart (Live)

🔗 [👉 Click here to view the Plotly Chart](https://warrior678.github.io/CAMPA-FUND-UTILIZATION/plotly_campa_chart.html)

This grouped bar chart compares fund allocation across 5 states in two financial years:
![Plotly Chart](./screenshots/plotly_fund_chart.png)

![CAMPA Plotly Chart](./screenshots/plotly_fund_chart.png)

### 📌 Insights from the Chart:
- **Bihar** saw a large increase in fund allocation from ₹125 Cr to ₹183 Cr.
- **Arunachal Pradesh** had zero fund allocation in 2020–21 despite ₹166 Cr in the prior year.
- **Andhra Pradesh** received lower funds in 2020–21.

---🔗 [Click here to view the interactive Plotly Chart (Live)](https://warrior678.github.io/CAMPA-FUND-UTILIZATION/plotly_campa_chart.html)


## 🐍 Python Code

Here is the Python code that generates the chart:

```python
import pandas as pd
import plotly.express as px

# Dataset
data = pd.DataFrame({
    "State": ["Andaman and Nicobar", "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar"],
    "Fund_2019_20": [0.01, 99.17, 166.20, 32.02, 125.39],
    "Fund_2020_21": [0.17, 59.56, 0.00, 22.28, 183.20]
})

# Reshape for Plotly
data_melted = data.melt(id_vars="State", var_name="Year", value_name="Fund")

# Plot
fig = px.bar(data_melted, x="State", y="Fund", color="Year", barmode="group",
             title="State-wise CAMPA Fund Allocation (2019–20 vs 2020–21)", text="Fund")
fig.update_layout(xaxis_title="State", yaxis_title="Fund (₹ Cr)", legend_title="Financial Year")
fig.update_traces(texttemplate='%{text:.2f}', textposition='outside')
fig.write_html("plotly_campa_chart.html")
fig.show()
```

---

## 🧠 Sample Insightful Questions Answered:

1. **Which state received the highest fund in FY 2020–21?**
   - Bihar (₹183.20 Cr)

2. **Which state had the highest drop in fund allocation?**
   - Arunachal Pradesh (from ₹166.20 Cr to ₹0)

3. **How many states received more funds in 2020–21 than 2019–20?**
   - Answerable via SQL grouping and comparison

---

## 🧩 21 SQL Queries (Easy → Hard)

### 🟢 Easy Queries
```sql
-- 1. Select all data
SELECT * FROM campa_fund_data;

-- 2. List unique states
SELECT DISTINCT state_name FROM campa_fund_data;

-- 3. Total funds allocated in 2019–20
SELECT SUM(fund_2019_20) AS total_2019 FROM campa_fund_data;

-- 4. Find null fund values
SELECT * FROM campa_fund_data WHERE fund_2020_21 IS NULL;

-- 5. States with funds > ₹100 Cr in 2019–20
SELECT state_name FROM campa_fund_data WHERE fund_2019_20 > 100;
```

### 🟡 Medium Queries
```sql
-- 6. Total funds by year and state
SELECT state_name, SUM(fund_2019_20 + fund_2020_21) AS total_fund FROM campa_fund_data GROUP BY state_name;

-- 7. States where fund increased
SELECT state_name FROM campa_fund_data WHERE fund_2020_21 > fund_2019_20;

-- 8. Percentage growth by state
SELECT state_name,
       ((fund_2020_21 - fund_2019_20) / NULLIF(fund_2019_20, 0)) * 100 AS percent_growth
FROM campa_fund_data;

-- 9. Average fund by year
SELECT AVG(fund_2019_20) AS avg_2019, AVG(fund_2020_21) AS avg_2020 FROM campa_fund_data;

-- 10. Total fund per year
SELECT SUM(fund_2019_20) AS total_19, SUM(fund_2020_21) AS total_20 FROM campa_fund_data;
```

### 🔴 Hard Queries
```sql
-- 11. Rank states by fund in 2020–21
SELECT state_name, fund_2020_21,
       RANK() OVER (ORDER BY fund_2020_21 DESC) AS rank_2020
FROM campa_fund_data;

-- 12. States with fund difference > ₹50 Cr
SELECT state_name, (fund_2020_21 - fund_2019_20) AS diff FROM campa_fund_data WHERE ABS(fund_2020_21 - fund_2019_20) > 50;

-- 13. Top 3 states in each year
SELECT * FROM (
  SELECT state_name, fund_2019_20, RANK() OVER (ORDER BY fund_2019_20 DESC) AS r1 FROM campa_fund_data
) a WHERE r1 <= 3;

-- 14. Compare top and bottom states
SELECT state_name, fund_2020_21 FROM campa_fund_data ORDER BY fund_2020_21 DESC LIMIT 1;
SELECT state_name, fund_2020_21 FROM campa_fund_data ORDER BY fund_2020_21 ASC LIMIT 1;

-- 15. States with no change in allocation
SELECT state_name FROM campa_fund_data WHERE fund_2020_21 = fund_2019_20;

-- 16. States with <50% utilization
SELECT state_name FROM campa_fund_data WHERE (fund_2020_21 < 0.5 * fund_2019_20);

-- 17. States with 0 fund in 2020–21
SELECT state_name FROM campa_fund_data WHERE fund_2020_21 = 0;

-- 18. Percentage of total fund per state
SELECT state_name,
       (fund_2019_20 + fund_2020_21) * 100.0 / 
       (SELECT SUM(fund_2019_20 + fund_2020_21) FROM campa_fund_data) AS percent_share
FROM campa_fund_data;

-- 19. Running total of funds
SELECT state_name,
       SUM(fund_2019_20 + fund_2020_21) OVER (ORDER BY state_name) AS running_total
FROM campa_fund_data;

-- 20. Cumulative distribution
SELECT state_name,
       CUME_DIST() OVER (ORDER BY fund_2020_21 DESC) AS cum_dist
FROM campa_fund_data;

-- 21. Compare year-over-year changes with CASE
SELECT state_name,
       CASE 
           WHEN fund_2020_21 > fund_2019_20 THEN 'Increased'
           WHEN fund_2020_21 < fund_2019_20 THEN 'Decreased'
           ELSE 'Same'
       END AS change_status
FROM campa_fund_data;
```

---

## ✅ What I Learned

- Managing messy datasets using **Excel** and **pandas**
- Writing optimized SQL for analytics and rankings
- Creating interactive charts using **Plotly**
- Documenting a multi-tool project professionally
- Making portfolio-ready projects using GitHub

---

## 📞 Contact

📧 **Email**: gk4137061@gmail.com 
🔗 [**LinkedIn**] https://www.linkedin.com/in/gautam-kumar-2935bb178/
📂 [**GitHub Portfolio**](https://github.com/warrior678)

---

Let me know if you’d like help linking this README directly to your repository. 💖



