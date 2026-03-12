use CPI_data;

Select * from dbo.clean_cpi_data;

-- How many unique states exist in the dataset?

Select COUNT(DISTINCT state) as total_state 
from dbo.clean_cpi_data;

-- How many records exist for each state?
SELECT state,COUNT(*) AS total_records
FROM dbo.clean_cpi_data
GROUP BY state;

-- What is the average CPI index for each state?
-- NOTE : index is a inbuilt- function in SQL so if we want to use it then we have to write them in []
SELECT state, AVG([index]) AS avg_cpi
FROM dbo.clean_cpi_data
GROUP BY state
ORDER BY avg_cpi DESC;

-- Which states experienced the highest CPI growth?
-- growth % = (max CPI - min CPI) / min CPI * 100
SELECT state,min([index]) as first_cpi, max([index]) as last_cpi,
((MAX([index]) - MIN([index])) / MIN([index]) * 100) AS growth_percent
FROM dbo.clean_cpi_data
GROUP BY state
ORDER BY growth_percent DESC;

-- Which 10 states have the highest CPI growth?
SELECT TOP 10 state,round(MIN([index]),2) AS first_cpi, round(MAX([index]),2) AS last_cpi,
       round(((MAX([index]) - MIN([index])) / MIN([index]) * 100),2) AS growth_percent
FROM dbo.clean_cpi_data
GROUP BY state
ORDER BY growth_percent DESC;

-- Which states have the highest CPI volatility?
-- STDEV() is used to calculate standard deviation
SELECT top 10 state , round(STDEV([index]),3) AS cpi_volatility
FROM dbo.clean_cpi_data
GROUP BY state
ORDER BY cpi_volatility DESC;

-- What is the average CPI index per year?
SELECT year , round(AVG([index]),3) as avg_cpi 
from dbo.clean_cpi_data
group by year
order by year asc;

-- How does CPI change per state per year?
Select state , year , round(avg([index]),2) as avg_cpi
from dbo.clean_cpi_data
group by state, year 
order by state ,year asc;

-- What is the average CPI per state across the entire dataset?
SELECT state, ROUND(AVG([index]),2) AS avg_cpi
FROM dbo.clean_cpi_data
GROUP BY state
ORDER BY avg_cpi DESC;
