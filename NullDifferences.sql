--In calendar year 2006, the CMO of Adventure Works executed a series of 
--promotions extending larger than normal discount amounts to resellers' 
--purchases of products across our Bikes category to drive larger orders 
--through this channel. These promotions were scaled back in 2007 and 
--replaced with a series of smaller promotional offers still targeting 
--the sale of Bikes but applicable across a wider range of order sizes. 
--Some of our larger resellers complained about this shift in promotional 
--practices, stating that their average discount amount on Bikes is smaller 
--in 2007 than in 2006. However, our CMO contends that the average discount 
--amount applied to Bicycle purchases across the reseller channel has 
--remained about the same between 2006 and 2007. How could both parties have
--such differing views of the situation?

--Provide a SQL query evaluating discount amounts applied to 'Bikes' in
--calendar years 2006 & 2007. Include averages of discount amount (with no 
-- consideration of order quantities) that reflect both the CMO and the 
-- reseller's point of views.

SELECT
	b.CalendarYear,
	AVG(a.DiscountAmount) as AvgDiscountAmountReseller_POV,
	AVG(COALESCE(a.DiscountAmount, 0)) as AvgDiscountAmountCMO_POV
FROM FactResellerSales a
INNER JOIN DimDate b
	ON a.OrderDateKey = b.DateKey
INNER JOIN DimProduct c
	ON a.ProductKey = c.ProductKey
WHERE
	c.EnglishProductCategoryName = 'Bikes' AND
	(b.CalendarYear = 2006 OR
	b.CalendarYear = 2007)
GROUP BY b.CalendarYear;