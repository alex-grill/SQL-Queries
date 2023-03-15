--Problem: Bring together three queries so that you show annual sales by 
--ProductAlternateKey in 2007 side-by-side with the corresponding sales for 
--2006. Be sure to join the 3 nested queries in a way so that each product 
--in the first set is preserved in the final results, regardless of whether 
--that product had sales in either 2006 or 2007.

SELECT
	x.ProductAlternateKey,
	y.TotalSales_2006,
	z.TotalSales_2007
FROM (
	SELECT DISTINCT 
		ProductAlternateKey 
	FROM DimProduct 
	WHERE EnglishProductCategoryName = 'Bikes'
	) x
LEFT OUTER JOIN (
	SELECT
		c.ProductAlternateKey,
		SUM(a.SalesAmount) AS TotalSales_2006
	FROM FactResellerSales a
	INNER JOIN DimDate b
		ON a.OrderDateKey = b.DateKey
	INNER JOIN DimProduct c
		ON a.ProductKey = c.ProductKey
	WHERE 
		b.CalendarYear = 2006 AND
		c.EnglishProductCategoryName = 'Bikes'
	GROUP BY c.ProductAlternateKey
	) y
	ON x.ProductAlternateKey = y.ProductAlternateKey
LEFT OUTER JOIN (
	SELECT
		g.ProductAlternateKey,
		SUM(e.SalesAmount) AS TotalSales_2007
	FROM FactResellerSales e
	INNER JOIN DimDate f
		ON e.OrderDateKey = f.DateKey
	INNER JOIN DimProduct g
		ON e.ProductKey = g.ProductKey
	WHERE 
		f.CalendarYear = 2007 AND
		g.EnglishProductCategoryName = 'Bikes'
	GROUP BY g.ProductAlternateKey
	) z
	ON x.ProductAlternateKey = z.ProductAlternateKey
ORDER BY x.ProductAlternateKey DESC;
