SQL Supply Chain Analysis: Inventory Risk and Supplier Delivery Performance
Project Overview
This project uses SQL to analyse supply chain data, with a focus on supplier delivery performance and inventory risk.

The analysis examines 840 purchase orders from 12 suppliers and investigates delivery delays, actual versus quoted lead times, and inventory cover margins. The goal is to identify suppliers and products that may require closer monitoring and to provide data-driven recommendations for improving supply chain reliability.

The analysis was performed using SQL, including filtering, aggregation, grouping, conditional logic, and joins across multiple tables.
Business Questions
The analysis aims to answer the following business questions:
1. Supplier Performance: Which suppliers have the highest delivery delays?
2. Inventory Risk: How many purchase orders have a negative inventory cover margin?
3. Product Risk: Which products are most frequently associated with a negative inventory cover margin?
4. Regional Performance: How do delivery delays differ between domestic, nearshore, and overseas suppliers?
5. Supplier Comparison: Do different suppliers show different delivery performance for the same products?
Dataset and Tables
The project uses a supply chain dataset containing three CSV files.
Table	Number of rows	Description
items	30	Contains product information, unit costs, daily demand, and safety cover days.
suppliers	12	Contains supplier names, regions, quoted lead times, and lateness factors.
purchase_orders	840	Contains purchase orders, order quantities, order dates, delivery times, and inventory cover margins.


Table Relationships
The tables were connected using SQL joins:
- purchase_orders.item_id = items.id
- purchase_orders.supplier_id = suppliers.id
These relationships made it possible to analyse purchase orders alongside product and supplier information.
Data Source
Database Sample – Supply Chain Dataset: Purchase Orders, Lead Times and Stockouts
SQL Methods
The project used the following SQL techniques to analyse supplier performance and inventory risk:
- SELECT and WHERE: Retrieved relevant data and filtered records based on specific conditions.
- Aggregate functions: Used COUNT(), AVG(), SUM(), MIN(), and MAX() to calculate summary statistics.
- GROUP BY: Grouped purchase orders by supplier, product, and region to compare performance.
- CASE WHEN: Classified orders according to whether their inventory cover margin was negative, zero, or positive.
- JOIN: Combined purchase order data with product and supplier information.
- ORDER BY: Sorted results to identify suppliers and products requiring closer attention.
- Calculated metrics: Analysed delivery delays and inventory cover margins using existing dataset columns.
These techniques helped transform raw supply chain data into structured results that could support business decisions.
Key Findings
1. Overall Delivery Performance
- Total purchase orders: 840
- Delayed orders: 672 (80%)
- Average actual lead time: 31.37 days
- Average quoted lead time: 24.84 days
- Average difference between actual and quoted lead time: 6.53 days
The results show that most purchase orders experienced a delivery delay. On average, actual lead times exceeded quoted lead times by approximately 6.53 days.
2. Inventory Cover Margin
The analysis identified the following distribution across the 840 purchase orders:
Inventory Cover Margin	Number of Orders	Percentage
Negative	260	31.0%
Zero	30	3.6%
Positive	550	65.5%
Total	840	100%


A negative inventory cover margin indicates that actual lead time exceeded the quoted lead time plus the safety cover allowance. These orders represent potential inventory risk, but do not confirm that a stockout occurred.
3. Supplier Performance
Pfeffer Group had the highest proportion of orders with a negative inventory cover margin: 35 out of 56 orders (62.5%). Wolf, Rau and Walker followed with 42 out of 73 orders (57.5%), while Doyle Group had 39 out of 72 orders (54.2%).

In contrast, Cruickshank - Christiansen and Pfeffer - Grant had no orders with a negative inventory cover margin in this dataset.

These results suggest that inventory risk varies across suppliers. However, differences in order volumes and product mix should be considered when comparing supplier performance.
4. Regional Delivery Performance
Supplier Region	Total Orders	Percentage of Orders Delayed	Average Delay
Nearshore	261	83.9%	7.95 days
Domestic	288	76.0%	6.64 days
Overseas	291	80.4%	5.16 days


Nearshore suppliers had the highest average delay and the highest percentage of delayed orders. Domestic suppliers had the lowest percentage of delayed orders, while overseas suppliers had the lowest average delay.
5. Products with Higher Inventory Risk
Several products showed relatively high proportions of orders with a negative inventory cover margin:
Product	Orders with Negative Margin	Percentage
ABS pellets, 25 kg bag	11 of 22	50.0%
Deburring tool	12 of 26	46.2%
Torque wrench, 40 Nm	11 of 25	44.0%
Foam corner protectors	14 of 32	43.8%
Expansion anchors, 50 pack	10 of 23	43.5%


These products may warrant closer monitoring. The findings are based on the observed purchase orders and should not be interpreted as proof of actual stockouts.
Recommendations
Based on the analysis, the following actions could help improve supply chain reliability:
1. Review high-risk suppliers. Investigate the delivery performance of suppliers with high proportions of negative inventory cover margins, particularly Pfeffer Group and Wolf, Rau and Walker.
2. Monitor high-risk products. Review safety cover levels and replenishment plans for products such as ABS pellets, deburring tools, and torque wrenches.
3. Review lead-time assumptions. Compare quoted lead times with actual delivery performance to determine whether planning assumptions need updating.
4. Investigate regional patterns. Examine why nearshore suppliers show higher average delays and whether changes to purchasing or delivery planning could reduce the impact.
5. Track performance over time. Repeat the analysis regularly to identify changes in supplier reliability and inventory risk.
These recommendations should be investigated further before making operational changes. The analysis identifies patterns and potential risks but does not establish their causes.
Limitations
- The analysis is based on the available dataset and may not represent every supply chain situation.
- A negative inventory cover margin indicates potential inventory risk, not a confirmed stockout.
- Supplier comparisons may be affected by differences in order volumes and product mix.
- The analysis identifies associations and patterns but does not establish causation.
Conclusion
This project demonstrates how SQL can be used to analyse supply chain data and identify patterns in supplier delivery performance and inventory risk.

By combining purchase order, product, and supplier information, the analysis identified frequent delivery delays, variations in supplier performance, and products with relatively high proportions of negative inventory cover margins.

The findings can help guide further investigation and support more informed supply chain decisions. The project also demonstrates practical use of SQL techniques, including filtering, aggregation, grouping, conditional logic, and joins.
