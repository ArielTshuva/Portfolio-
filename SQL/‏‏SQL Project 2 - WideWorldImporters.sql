--SQL PROJECT - 2 --
--Update on the use of AI:
--Throughout the assignment, I had used the assistance of AI in several ways:
--I used Ai to refresh my knowledge of SQL Syntax
--I used Ai to correct SQL syntax mistakes I could not find after several revisions (usually ',' '/' '.' and such)
--I used AI in order to give me different syntax options to apply a specific action I wanted to do on the data 
--	(I used it in Q1 to get ideas on how to calculate the growth_percentage - I chose to use Lead in the end). 


--Q1

use WideWorldImporters;

WITH months AS (
    SELECT 
        YEAR(PickingCompletedWhen) AS year,
        COUNT(DISTINCT MONTH(PickingCompletedWhen)) AS numberofdistinctmonths,
        SUM(UnitPrice * PickedQuantity) AS incomeperyear
    FROM 
        Sales.OrderLines
    GROUP BY 
        YEAR(PickingCompletedWhen)
)

SELECT 
    m.year,
    m.incomeperyear,
    m.numberofdistinctmonths,
    LEAD(m.incomeperyear, 1, NULL) OVER (ORDER BY m.year) AS yearlyincome,
    CASE 
        WHEN LEAD(m.incomeperyear, 1, NULL) OVER (ORDER BY m.year) IS NULL THEN NULL
        WHEN m.incomeperyear = 0 THEN NULL
        ELSE (LEAD(m.incomeperyear, 1, NULL) OVER (ORDER BY m.year) - m.incomeperyear) / m.incomeperyear * 100
    END AS growthrate
FROM 
    months AS m
ORDER BY 
    m.year;

--Action taken here
--1. createing a cte with the calculation of all the distinct months and thier profits
--2. using the cte in unison with LEAD function to calculate the groth percentege per year 
--3. I did not manage to make it look like the picture in the assignment - had a problem replacing it with LAG()

----------------------------------------------------------------------------------------------

--Q2

WITH cte1 AS (
    SELECT  
        YEAR(o.OrderDate) AS year, 
        CASE
            WHEN MONTH(o.OrderDate) IN (1, 2, 3) THEN 1
            WHEN MONTH(o.OrderDate) IN (4, 5, 6) THEN 2
            WHEN MONTH(o.OrderDate) IN (7, 8, 9) THEN 3
            ELSE 4
        END AS quarter,
        c.CustomerName, 
        SUM(ol.UnitPrice * ol.PickedQuantity) AS incomeperyear,
        ROW_NUMBER() OVER (PARTITION BY YEAR(o.OrderDate), 
                                      CASE
                                          WHEN MONTH(o.OrderDate) IN (1, 2, 3) THEN 1
                                          WHEN MONTH(o.OrderDate) IN (4, 5, 6) THEN 2
                                          WHEN MONTH(o.OrderDate) IN (7, 8, 9) THEN 3
                                          ELSE 4
                                      END
                           ORDER BY SUM(ol.UnitPrice * ol.PickedQuantity) ASC) AS rn
    FROM 
        Sales.OrderLines AS ol
        JOIN Sales.Orders AS o ON ol.OrderID = o.OrderID 
        JOIN Sales.Customers AS c ON o.CustomerID = c.CustomerID
    GROUP BY 
        YEAR(o.OrderDate), 
        CASE
            WHEN MONTH(o.OrderDate) IN (1, 2, 3) THEN 1
            WHEN MONTH(o.OrderDate) IN (4, 5, 6) THEN 2
            WHEN MONTH(o.OrderDate) IN (7, 8, 9) THEN 3
            ELSE 4
        END,
        c.CustomerName
)
SELECT *
FROM 
	cte1
WHERE 
	rn <= 5
	AND year IN (2013, 2014, 2015, 2016)
ORDER BY 
	year, 
	quarter, 
	incomeperyear desc;

--Action taken here:
--pre action - create a cte for later use
--1. devide the year into quarters
--2. calculate the incomeperyear
--3. create a distincr rn for every customer partitioned by the quarters
--4. of course a head of time i joined all of the nessasery tables together
-- final action - pull out the relevant info and order it correctly

----------------------------------------------------------------------------------------
--Q3

select distinct top 10 
	 vo.StockItemID, 
	 st.StockItemName, 
	 sum((vo.ExtendedPrice - vo.TaxAmount)) as totalprofit

from Sales.InvoiceLines as vo 
join 
	 [Warehouse].[StockItems] as St 
on 
	 vo.StockItemID = St.StockItemID

group by 
	 vo.StockItemID, 
	 st.StockItemName

order by 
	  totalprofit desc;

--Actions taken here:
--1. joining the relevant tables
--2. selecting the relevant colums and calculating the totalprofit
--3. gouping and ordering
-------------------------------------------------------------------------------------
--Q4


select distinct
	row_number() over (partition by StockItemID order by RecommendedRetailPrice - UnitPrice) as rn,
	StockItemID,
	StockItemName,
	UnitPrice,
	RecommendedRetailPrice,
	RecommendedRetailPrice - UnitPrice as NominalRetailPrice

from 
	Warehouse.StockItems

order by 
	NominalRetailPrice desc;


--action taken here:
--1. tried and failed the rn partition :(
--2. took out the nessasery colums
--3. calculated the nominalprice
---------------------------------------------------------------------------------------------------
--Q5

SELECT 
    CAST(ps.SupplierID AS VARCHAR(10)) + '-' + CAST(ps.SupplierName AS VARCHAR(50)) AS SupplierDetails,
    STUFF(
            (SELECT 
			'/' + CAST(ws.StockItemID AS VARCHAR(10)) + ' ' + ws.StockItemName
            FROM 
				[Warehouse].[StockItems] AS ws
            WHERE 
				ws.SupplierID = ps.SupplierID
            FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS ProductDetails
FROM 
    [Purchasing].[Suppliers] AS ps
--HAVING 
--    STUFF(
--        (
--            SELECT '/' + CAST(ws.StockItemID AS VARCHAR(10)) + ' ' + ws.StockItemName
--            FROM [Warehouse].[StockItems] AS ws
--            WHERE ws.SupplierID = ps.SupplierID
--            FOR XML PATH(''), TYPE
--        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') IS NOT NULL
ORDER BY 
    ps.SupplierID;


-- Action taken here:
--1. creating the supplierinfo colum using cast() 
--2. using the stuff() function i was able to.. well stuff all of the relevant info about the product in a list in every row
--	(took me a second to correctly utilize the xml path in r.138 - 139)
--3. orderd by supplierid
-- i did not hoever succeeded in deleting the nulls :( - the green part is my best attempt
---------------------------------------------------------------------------------
--	Q6 -- perfect :)))

SELECT TOP 5 
	sc.CustomerID, 
	ac.CityName, 
	ac2.CountryName, 
	ac2.Continent, 
	ac2.Region, 
	sum(sll.ExtendedPrice) as totalextendedprice
from 
	Sales.InvoiceLines as sll
	
join 
		Sales.Invoices as sl
on 
	sll.InvoiceID = sl.InvoiceID
	
join 
		Sales.Customers as sc
on 
	sl.[CustomerID] = sc.[CustomerID]
	
join 
		Application.Cities as ac
on 
	sc.[DeliveryCityID] = ac.[CityID]
	
join 
		Application.StateProvinces as sp
on 
	ac.[StateProvinceID] = sp.[StateProvinceID]
	
join 
		Application.Countries ac2
on 
	sp.[CountryID] = ac2.[CountryID]

group by sc.CustomerID,	
		 ac.CityName, 
		 ac2.CountryName, 
		 ac2.Continent, 
		 ac2.Region

order by 
	 sum(sll.ExtendedPrice) desc;

--Actions taken here:
--1. alot of joins
--2. pulling out the colums and caalculating the totalextendedprice
--3. ordering by this totalextendedprice
----------------------------------------------------------------------------
--Q7

with [monthlytotal] as (
					  SELECT 
						  year(o.OrderDate) as OrderYear, 
						  month(o.OrderDate) as OrderMonth, 
						  SUM (so.PickedQuantity*so.UnitPrice) as MonthlyTotal
					  FROM 
						Sales.OrderLines as so
					  join	
						Sales.Orders as o
					  on 
						so.OrderID = o.OrderID
					  GROUP BY 
						YEAR(o.OrderDate), 
						month(o.OrderDate)
					  )

SELECT 
    OrderYear, 
    OrderMonth, 
    MonthlyTotal, 
    SUM(MonthlyTotal) OVER (PARTITION BY OrderYear ORDER BY OrderMonth) AS CumulativeTotal
    --CASE 
    --    WHEN GROUPING(OrderYear) = 1 THEN 'Yearly Total'
    --    ELSE CAST(OrderMonth AS VARCHAR)
    --END AS MonthOrTotal
FROM 
    monthlytotal;
--GROUP BY
    --ROLLUP(OrderYear, OrderMonth)


--Actions taken here: 
--1. using a cte to calculate the total amout of products orderd 
--2. using the sum() and partitioning acording to OrderYear and ordering by OrderMonth to vreate the requested look for the table
-- unfortunataly could not figur out how to create the general profit for that year - tried using rollup but it did not work - tried with grouping sets as well..
--------------------------------------------------------------------------------
--Q8


SELECT *
FROM   (
		SELECT 
			MONTH(OrderDate) as month, 
			YEAR(OrderDate) as year, 
			isnull(count(OrderID), 0) as numberoforders
		FROM 
			Sales.Orders
		group by 
			MONTH(OrderDate), 
			YEAR(OrderDate)
		) as pivotme

pivot  ( 
		SUM(numberoforders)  
		FOR year IN ([2013], [2014], [2015], [2016])
		) AS pivot1;

-- onother way to pivot this: (just for fun)
--select*
--from (
--select 
--MONTH(OrderDate) as month, 
--YEAR(OrderDate) as year, 
--count(OrderID) as numberoforders
--from Sales.Orders
--group by 
--MONTH(OrderDate), 
--YEAR(OrderDate)) 
--as pivotme
--pivot ( SUM(numberoforders)  
--    FOR month IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
--) AS pivot1;

--Actions taken here:
--1. pulled out the colums and grouped correctly
--2. pivoted
-- did not succeed however in deleting the nulls
-----------------------------------------------------------
--Q9

WITH RankedOrders AS (
						SELECT 
							sc.CustomerID, 
							sc.CustomerName, 
							so.OrderDate,
							ROW_NUMBER() OVER (PARTITION BY sc.CustomerID ORDER BY so.OrderDate DESC) AS RowNum
						FROM 
							Sales.Orders AS so
						JOIN 
							Sales.Customers AS sc 
						ON 
							so.CustomerID = sc.CustomerID
					 ),
lagorderdate as (
					SELECT 
						sc.CustomerID, 
						sc.CustomerName, 
						so.OrderDate,
						LAG(so.OrderDate) OVER (PARTITION BY sc.CustomerID ORDER BY so.OrderDate) AS lagorderdate,
						datediff(day, LAG(so.OrderDate) OVER (PARTITION BY sc.CustomerID ORDER BY so.OrderDate), so.OrderDate) as datedifforderrs
					FROM 
						Sales.Orders AS so
					JOIN 
						Sales.Customers AS sc 
					ON 
						so.CustomerID = sc.CustomerID
				),
Lastorder as (
				SELECT 
					CustomerID, 
					CustomerName,
					OrderDate AS LastOrderDate
				FROM 
					RankedOrders
				WHERE 
					RowNum = 1
			  ),

secondlastorder as (
					SELECT 
						CustomerID, 
						CustomerName, 
						OrderDate AS SecondLastOrderDate
					FROM 
						RankedOrders
					WHERE 
						RowNum = 2
				    )

Select 
	lo.CustomerID, 
	lo.CustomerName, 
	lo.LastOrderDate as OrderDate, 
	slo.SecondLastOrderDate as PrevOprderDate,
	DATEDIFF(DAY, slo.SecondLastOrderDate, lo.LastOrderDate) as DaysSinceLastOrder,
	AVG(lagd.datedifforderrs) as AVGdays,
	iif(DATEDIFF(DAY, slo.SecondLastOrderDate, lo.LastOrderDate) > 2*AVG(lagd.datedifforderrs), 'Active', 'Potential Churn') as CustomerStatus
From 
	Lastorder as lo
join 
	secondlastorder slo 
on 
	lo.CustomerID = slo.CustomerID
join 
	lagorderdate as lagd
on 
	slo.CustomerID = lagd.CustomerID

group by 
	lo.CustomerID,
	lo.CustomerName, 
	lo.LastOrderDate, 
	slo.SecondLastOrderDate,
	slo.SecondLastOrderDate,
	DATEDIFF(DAY, slo.SecondLastOrderDate, lo.LastOrderDate);

--Actions taken here:
--1. creating a cte where I used rn to seperate the orderdates for later use 
--2. creating a cte where I calculated the dayssincelastorder using lag() and daudiff
--3. creating a cte for calcullating the last order
--4. creating a cte for calcullating the second to last order
--5. pulling all of the relevant colums and using the 'ii' function to create the CustomerStatus colum
----- does not look like the pic - because the use of rn i think - could not think of another way to do it.. 
----------------------------------------------------------------------
--Q10


WITH FilteredCustomers AS (
    SELECT 
        sc.CustomerID,
        cc.CustomerCategoryName, 
        sc.CustomerName
    FROM 
        Sales.Customers AS sc
    JOIN 
        Sales.CustomerCategories AS cc
    ON 
        sc.CustomerCategoryID = cc.CustomerCategoryID
    WHERE 
        sc.CustomerName LIKE '%Tailspin%' OR sc.CustomerName LIKE '%Wingtip%'
),
DistinctCustomers AS (
    SELECT 
        cc.CustomerCategoryID,
        COUNT(DISTINCT sc.CustomerID) AS DistinctCustomers 
    FROM 
        Sales.Customers AS sc
    JOIN 
        Sales.CustomerCategories AS cc
    ON 
        sc.CustomerCategoryID = cc.CustomerCategoryID
    GROUP BY
        cc.CustomerCategoryID
),
TotalCustomers AS (
    SELECT 
        COUNT(DISTINCT CustomerID) AS TotalCustomerCount
    FROM 
        Sales.Customers
)
SELECT 
    cc.CustomerCategoryName, 
    dc.DistinctCustomers, 
	tc.TotalCustomerCount,
    CAST((dc.DistinctCustomers * 1.0 / tc.TotalCustomerCount) * 100 AS VARCHAR(20)) + '%' AS RelativeDistribution
FROM 
    DistinctCustomers AS dc
JOIN 
    Sales.CustomerCategories AS cc
ON 
    dc.CustomerCategoryID = cc.CustomerCategoryID
CROSS JOIN 
    TotalCustomers AS tc
ORDER BY 
    RelativeDistribution DESC;

-- Action taken here: 
--1. using a cte to filter the customers by the names requested
--2. using a second cte to count the amount of distinct customers
--3. using a second cte to count the total amount of customers
--4. joining the cte's
--5. calculating grouth percentege and ordering by RelativeDistribution
-------------------------------------------------------------------------
--END OF ASSIGNMENT