# Power BI Restaurant Analysis: Diagnosing Declining Sales for Streetway

> **Project Status:** Completed (November 2025)
> **Portfolio Project:** A comprehensive Business Intelligence solution built in Power BI to diagnose the root cause of declining Year-on-Year (YoY) sales for the Streetway restaurant outlet and provide actionable, data-driven recommendations.

[Image: Insert Screenshot of Sales Dashboard Here]
[Image: Insert Screenshot of Customer Dashboard Here]

---

## 1. 📈 The Business Problem

Streetway's management team was facing a persistent **decline in Year-on-Year (YoY) sales**. Their existing reporting method—a high-level, manually-compiled turnover chart—correctly identified the *problem* (declining revenue) but offered no diagnostic power to understand the *cause*.

The core business question was: **Are we losing customers, or are our customers spending less?**

## 2. 🎯 Project Objectives

The primary objective was to transition Streetway from basic manual reporting to a dynamic, analytical BI solution.

* **Diagnose:** Identify the primary driver of the sales decline (Customer Count vs. Average Spend).
* **Analyze:** Segment performance by day of week, product category, and customer type.
* **Visualize:** Develop two interactive Power BI dashboards:
    1.  **Sales Dashboard:** An executive summary focused on revenue, budget variance, and YoY trends.
    2.  **Customer Dashboard:** A deep-dive analysis of customer footfall (CC) and Average Spend Per Head (ASPH).
* **Recommend:** Provide specific, data-driven strategies to reverse the negative sales trend.

## 3. 📊 Dashboard Design

This solution consists of two interconnected Power BI dashboards:

### A. Sales & Revenue Dashboard (The "What")
This dashboard serves as the high-level executive summary.
* **Key Metrics:** Total Sales, Sales vs. Budget, YoY Sales %, and YoY Sales Variance.
* **Key Visuals:** A central KPI card cluster, YoY Sales Trend (Area Chart), Sales by Day of Week (Bar Chart), and a Budget Variance Heatmap.
* **Purpose:** To provide a "mission control" view of financial performance at a glance.

### B. Customer & Spend Dashboard (The "Why")
This dashboard is the diagnostic tool, focusing on the *drivers* behind the sales numbers.
* **Key Metrics:** Customer Count (CC), YoY CC %, Average Spend Per Head (ASPH), and YoY ASPH %.
* **Key Visuals:** Dual-axis line chart comparing YoY trends for CC and ASPH, a scatter plot of CC vs. ASPH by Day, and KPI cards for key customer metrics.
* **Purpose:** To answer the core business question. This dashboard clearly isolates ASPH as the primary issue.

## 4. 💡 Key Insights & Recommendations

My analysis of the data revealed that the sales decline was not due to a failure to attract customers, but a failure to maximize their value.

* **Insight 1: Average Spend is the Root Cause.**
    The primary driver of the revenue decline is a significant **drop in Average Spend Per Head (ASPH)**. While Customer Count (CC) remained relatively stable or saw minor fluctuations, the ASPH (YoY ASPH Variance) was consistently and significantly negative, especially on high-traffic days.

* **Insight 2: All Days Are Underperforming.**
    The decline in spend is not isolated to a specific "problem day." The `YOY ASPH VARIANCE` is negative across the board, indicating a systemic issue with pricing, upselling, or menu mix.

* **Insight 3 (Inferred): High Churn / Low Spend from New Customers.**
    The Customer Dashboard (conceptual) would segment this further, likely revealing that new customers have a much lower ASPH than returning customers, and a high churn rate (i.e., they do not return for a second visit).

### Actionable Recommendations
1.  **Launch Upsell/Cross-Sell Initiatives:** The problem is "basket size." Immediately implement staff training and POS (Point of Sale) prompts focused on increasing ASPH through "add-on" items (e.g., beverages, sides, desserts).
2.  **Menu Engineering:** Analyze product-level data (if available) to identify and promote high-margin, high-ASPH items. Create "bundle" or "set menu" deals that encourage a higher spend than à la carte ordering.
3.  **Implement a "First Visit" Bounce-Back Offer:** To combat new customer churn, offer a "10% off your next visit" incentive to capture customer data and encourage a second visit, converting them into a "returning" customer.

## 5. 🛠️ Technical Logic & Data Model

* **Data Source:** `Streetway_Turnover_Cleaned_October2025.xlsx`
* **Data Transformation:** Power Query (M) for unpivoting, date formatting, and data type correction.
* **Data Modeling:** A simple Star Schema with a `Fact_Sales` table connected to `Dim_Date` and (conceptually) `Dim_Product` and `Dim_Customer` tables.
* **Key DAX Measures (based on provided data):**

```dax
-- Simple financial sum
Total Sales = SUM('Sales'[ACTUAL SALES])

-- Year-on-Year Sales
Sales LY = SUM('Sales'[LAST YEAR SALES])
YoY Sales Variance = [Total Sales] - [Sales LY]
YoY Sales % = DIVIDE( [YoY Sales Variance], [Sales LY] )

-- Customer Count (Footfall)
Total CC = SUM('Sales'[CC THIS YEAR])
CC LY = SUM('Sales'[CC LAST YEAR])
YoY CC % = DIVIDE( ([Total CC] - [CC LY]), [CC LY] )

-- Average Spend Per Head (The Key Metric)
ASPH = DIVIDE( [Total Sales], [Total CC] )
ASPH LY = DIVIDE( [Sales LY], [CC LY] )
YoY ASPH % = DIVIDE( ([ASPH] - [ASPH LY]), [ASPH LY] )
