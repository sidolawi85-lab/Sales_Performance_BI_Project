-- Use a Common Table Expression (CTE) to perform initial calculations.
WITH CALCULATIONS AS 
 (SELECT
  DATE,  -- Base column
  DAY,   -- Base column
  `ACTUAL SALES`,
  `LAST YEAR SALES`,
  `BUDGETED SALES`,
  
    -- Primary Sales Variances (Rounded to 0 decimal places for whole numbers)
    ROUND(`ACTUAL SALES` - `BUDGETED SALES`, 0) AS `BUDGET VARIANCE`,
    ROUND(`ACTUAL SALES` - `LAST YEAR SALES`, 0) AS `YOY SALES VARIANCE`,
  
    -- Customer Count (CC) Metrics
  `CC THIS YEAR`,
  `CC LAST YEAR`,
  `CC BUDGETED `, -- Note the trailing space is required to match the actual column name!
  
    -- Primary CC Variances (Rounded to 0 decimal places)
    ROUND(`CC THIS YEAR` - `CC BUDGETED `, 0) AS `CC BUDGET VARIANCE`,
    ROUND(`CC THIS YEAR` - `CC LAST YEAR`, 0) AS `YOY CC VARIANCE`,
  
    -- Average Sale Per Head (ASPH) calculations (Rounded to 2 decimal places)
    ROUND((`ACTUAL SALES`)/(`CC THIS YEAR`),2) AS `ASPH THIS YEAR`,
    ROUND((`LAST YEAR SALES`)/(`CC LAST YEAR`),2) AS `ASPH LAST YEAR`,
    ROUND((`BUDGETED SALES`)/(`CC BUDGETED `),2) AS `ASPH BUDGETED`
  
FROM
  streetway_sales.sales_data) -- Your data source

-- Final SELECT statement: 
-- 1. Retrieves all columns/calculations from the temporary 'CALCULATIONS' CTE.
-- 2. Calculates the final-level variances using the ASPH columns created above.
SELECT 
    *, -- Selects all columns from the CTE (DATE, DAY, Sales, CC, and first-level variances)
    
    -- Second-level calculations: ASPH Variances (Rounded to 2 decimal places)
    ROUND((`ASPH THIS YEAR` - `ASPH LAST YEAR`),2) AS `YOY ASPH VARIANCE`,
    ROUND((`ASPH THIS YEAR` - `ASPH BUDGETED`),2) AS `ASPH BUDGET VARIANCE`
   FROM CALCULATIONS