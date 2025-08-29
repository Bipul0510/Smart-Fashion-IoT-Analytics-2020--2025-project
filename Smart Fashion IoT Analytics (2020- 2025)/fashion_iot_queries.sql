-- Project Name: "Smart Fashion IoT Analytics (2020- 2025)"

-- Queries and solutions for 'fashion_iot_data' dataset


create database Smart_Fashion_IoT_Analytics

use Smart_Fashion_IoT_Analytics

select * from fashion_iot_data

/*1) Top 5 cities where IoT-enabled fashion devices are most popular */


SELECT TOP 5 City, 
             COUNT(*) as IoT_Sales,
             SUM(CASE WHEN iot_feature_used = 'Yes' THEN 1 ELSE 0 END) AS total_times_IoT_used
FROM fashion_iot_data
WHERE IoT_Feature_Used = 'yes'
GROUP BY City
ORDER BY IoT_Sales DESC;


/* 2) Average carbon footprint per Product_Category */


SELECT Product_Category, 
       ROUND(AVG(Carbon_Footprint_gCO2),2) as Avg_CO2
FROM fashion_iot_data
GROUP BY Product_Category;

/* 3) Identify repeat customers who used IoT features > 5 times */


SELECT customer_id,
       SUM(CASE WHEN iot_feature_used = 'Yes' THEN 1 ELSE 0 END) as total_times_IoT_used

FROM fashion_iot_data
GROUP BY customer_id
HAVING SUM(CASE WHEN iot_feature_used = 'Yes' THEN 1 ELSE 0 END) >5
ORDER BY total_times_IoT_used DESC;



/* 4) Sales growth comparison (Smartwatch vs IoT Sneakers) */


SELECT 
    YEAR(Purchase_Date) as Year,
    ROUND(SUM(CASE WHEN Product_Category = 'Smartwatch' THEN Total_Spend ELSE 0 END),2) as Smartwatch_Sales,
    ROUND(SUM(CASE WHEN Product_Category = 'IoT Sneakers' THEN Total_Spend ELSE 0 END),2) as IoT_Sneakers_Sales
FROM fashion_iot_data
GROUP BY YEAR(Purchase_Date)
ORDER BY Year;

/* 5) Connectivity preference segmentation */


SELECT Device_Connectivity, 
       COUNT(*) as connection_count

FROM fashion_iot_data
GROUP BY Device_Connectivity
ORDER BY 2 DESC;

-------------------------------------------------------------------- End of SQL script-------------------------------------------------------------------------
