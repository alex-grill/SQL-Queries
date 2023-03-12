--Problem: You`ve been asked to compare the average number of lines per sales order			
--by calendar year for sales orders to resellers. Perform your average calculations in 
--a manner that preserves a consistent level of accuracy.  Present the results with two			
--decimal places present. Be sure to use fields that help explain your logic, not just 
--arbitrary fields that return the correct result.

WITH LinesPerSalesOrder as (
	SELECT
		a.SalesOrderNumber ,
		b.CalendarYear ,
		COUNT(*) as Lines
	FROM FactResellerSales a
	INNER JOIN DimDate b
		ON a.OrderDateKey = b.DateKey
	GROUP BY 
		a.SalesOrderNumber, 
		b.CalendarYear
	)
SELECT
	CalendarYear,
	SUM(Lines) as TotalNumberOfLines,
	COUNT(*) as TotalNumberOfOrders,
	ROUND(CAST(SUM(Lines) as FLOAT(53)) / CAST(COUNT(*) as FLOAT(53)), 2) as AverageLinesPerSalesOrder
FROM LinesPerSalesOrder
GROUP BY CalendarYear;