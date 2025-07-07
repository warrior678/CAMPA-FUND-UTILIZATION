-- ===========================================
-- CAMPA FUND UTILIZATION - SQL QUERIES
-- Author: Gautam Kumar
-- Project Duration: March 2025 – June 2025
-- Total Queries: 21 (Easy, Medium, Hard)
-- ===========================================

-- 🟢 EASY LEVEL (1–7)

-- 1. Show all records
SELECT * FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)];

-- 2. List all states and total funds
SELECT State_UT, Total_Funds_Numeric FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)];

-- 3. Sort states by 2020-21 funds in descending order
SELECT State_UT, Sum_of_Campa_Funds_2020_21 
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
ORDER BY Sum_of_Campa_Funds_2020_21 DESC;

-- 4. Find total number of states
SELECT COUNT(*) AS Total_States 
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)];

-- 5. Filter states with funds > ₹100 in 2019-20
SELECT State_UT 
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
WHERE Sum_of_Campa_Funds_2019_20 > 100;

-- 6. States with 0 funds in both years
SELECT State_UT 
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
WHERE Sum_of_Campa_Funds_2019_20 = 0 AND Sum_of_Campa_Funds_2020_21 = 0;

-- 7. Top 5 states based on total funds
SELECT TOP 5 State_UT, Total_Funds_Numeric 
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
ORDER BY Total_Funds_Numeric DESC;

-- 🟡 MEDIUM LEVEL (8–14)

-- 8. Total funds given in each year
SELECT 
  SUM(Sum_of_Campa_Funds_2019_20) AS Total_2019_20,
  SUM(Sum_of_Campa_Funds_2020_21) AS Total_2020_21
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)];

-- 9. Difference in funding between two years
SELECT 
  State_UT,
  Sum_of_Campa_Funds_2020_21 - Sum_of_Campa_Funds_2019_20 AS Fund_Difference
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)];

-- 10. Classify states based on funding amount
SELECT 
  State_UT,
  Total_Funds_Numeric,
  CASE 
    WHEN Total_Funds_Numeric >= 5000 THEN 'High'
    WHEN Total_Funds_Numeric BETWEEN 1000 AND 4999 THEN 'Medium'
    ELSE 'Low'
  END AS Fund_Level
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)];

-- 11. Average funds per state
SELECT 
  AVG(Sum_of_Campa_Funds_2019_20) AS Avg_2019,
  AVG(Sum_of_Campa_Funds_2020_21) AS Avg_2020
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)];

-- 12. Count of states receiving more in 2020-21
SELECT COUNT(*) AS Count_More_2020 
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
WHERE Sum_of_Campa_Funds_2020_21 > Sum_of_Campa_Funds_2019_20;

-- 13. States with total funds between ₹2000 and ₹5000
SELECT State_UT, Total_Funds_Numeric 
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
WHERE Total_Funds_Numeric BETWEEN 2000 AND 5000;

-- 14. Extract state name from Top_States column
SELECT 
  Top_States,
  RIGHT(Top_States, LEN(Top_States) - CHARINDEX('.', Top_States)) AS Clean_State_Name
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)];

-- 🔴 HARD LEVEL (15–21)

-- 15. Top 3 states with highest fund increase
SELECT TOP 3 
  State_UT,
  Sum_of_Campa_Funds_2019_20,
  Sum_of_Campa_Funds_2020_21,
  (Sum_of_Campa_Funds_2020_21 - Sum_of_Campa_Funds_2019_20) AS Increase
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
ORDER BY Increase DESC;

-- 16. States where funds decreased from 2019-20 to 2020-21
SELECT State_UT 
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
WHERE Sum_of_Campa_Funds_2020_21 < Sum_of_Campa_Funds_2019_20;

-- 17. Rank states based on total funds
SELECT 
  State_UT,
  Total_Funds_Numeric,
  RANK() OVER (ORDER BY Total_Funds_Numeric DESC) AS Fund_Rank
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)];

-- 18. States in top 10 by 2020-21 but not in 2019-20
SELECT State_UT FROM (
  SELECT State_UT,
         RANK() OVER (ORDER BY Sum_of_Campa_Funds_2020_21 DESC) AS Rank2020,
         RANK() OVER (ORDER BY Sum_of_Campa_Funds_2019_20 DESC) AS Rank2019
  FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
) t
WHERE Rank2020 <= 10 AND Rank2019 > 10;

-- 19. Compare total funds of top 5 vs bottom 5 states
SELECT 'Top 5' AS GroupName, SUM(Total_Funds_Numeric) AS TotalFunds
FROM (
  SELECT TOP 5 Total_Funds_Numeric 
  FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
  ORDER BY Total_Funds_Numeric DESC
) t
UNION
SELECT 'Bottom 5', SUM(Total_Funds_Numeric)
FROM (
  SELECT TOP 5 Total_Funds_Numeric 
  FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
  ORDER BY Total_Funds_Numeric ASC
) b;

-- 20. State(s) with max total fund
SELECT State_UT 
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
WHERE Total_Funds_Numeric = (
  SELECT MAX(Total_Funds_Numeric) 
  FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
);

-- 21. Percentage share of each state in total funds
SELECT 
  State_UT,
  Total_Funds_Numeric,
  ROUND((Total_Funds_Numeric * 100.0) / 
        (SELECT SUM(Total_Funds_Numeric) FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]), 2) 
        AS Percentage_Share
FROM [dbo].[CAMPA FUND UTILIZATION(Dashboard)]
ORDER BY Percentage_Share DESC;