
-- 1. Count total and delayed purchase orders

SELECT
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN delay_days > 0 THEN 1
            ELSE 0
        END
    ) AS delayed_orders
FROM supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_purchase_orders;



-- 2. Count orders by inventory cover margin status

SELECT
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN cover_margin_days < 0 THEN 1
        ELSE 0
    END) AS negative_margin_orders,
    SUM(CASE
        WHEN cover_margin_days = 0 THEN 1
        ELSE 0
    END) AS zero_margin_orders,
    SUM(CASE
        WHEN cover_margin_days > 0 THEN 1
        ELSE 0
    END) AS positive_margin_orders
FROM supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_purchase_orders;


-- 3. Compare delivery delays by supplier

SELECT
    s.supplier_name,
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN po.delay_days > 0 THEN 1
        ELSE 0
    END) AS delayed_orders,
    ROUND(
        100.0 * SUM(CASE
            WHEN po.delay_days > 0 THEN 1
            ELSE 0
        END) / COUNT(*),
        1
    ) AS delayed_percentage
FROM supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_purchase_orders po
JOIN supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_suppliers s
    ON po.supplier_id = s.id
GROUP BY s.supplier_name
ORDER BY delayed_percentage DESC;

-- 4. Compare delivery delays by supplier region

SELECT
    s.supplier_region,
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN po.delay_days > 0 THEN 1
        ELSE 0
    END) AS delayed_orders,
    ROUND(AVG(po.delay_days), 2) AS avg_delay_days,
    ROUND(
        100.0 * SUM(CASE
            WHEN po.delay_days > 0 THEN 1
            ELSE 0
        END) / COUNT(*),
        1
    ) AS delayed_percentage
FROM supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_purchase_orders po
JOIN supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_suppliers s
    ON po.supplier_id = s.id
GROUP BY s.supplier_region
ORDER BY avg_delay_days DESC;

-- 5. Identify products with the highest average delivery delays

SELECT
    i.sku,
    i.item_label,
    i.category,
    COUNT(*) AS total_orders,
    ROUND(AVG(po.delay_days), 2) AS avg_delay_days,
    SUM(CASE
        WHEN po.delay_days > 0 THEN 1
        ELSE 0
    END) AS delayed_orders
FROM supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_purchase_orders po
JOIN supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_items i
    ON po.item_id = i.id
GROUP BY
    i.sku,
    i.item_label,
    i.category
ORDER BY avg_delay_days DESC
LIMIT 10;

-- 6. Identify products with the highest inventory risk

SELECT
    i.sku,
    i.item_label,
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN po.cover_margin_days < 0 THEN 1
        ELSE 0
    END) AS negative_margin_orders,
    ROUND(
        100.0 * SUM(CASE
            WHEN po.cover_margin_days < 0 THEN 1
            ELSE 0
        END) / COUNT(*),
        1
    ) AS inventory_risk_percentage,
    ROUND(AVG(po.cover_margin_days), 2) AS avg_cover_margin_days
FROM supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_purchase_orders po
JOIN supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_items i
    ON po.item_id = i.id
GROUP BY
    i.sku,
    i.item_label
ORDER BY inventory_risk_percentage DESC, avg_cover_margin_days ASC
LIMIT 10;

-- 7. Identify suppliers with the highest inventory risk

SELECT
    s.supplier_name,
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN po.cover_margin_days < 0 THEN 1
        ELSE 0
    END) AS negative_margin_orders,
    ROUND(
        100.0 * SUM(CASE
            WHEN po.cover_margin_days < 0 THEN 1
            ELSE 0
        END) / COUNT(*),
        1
    ) AS inventory_risk_percentage,
    ROUND(AVG(po.delay_days), 2) AS avg_delay_days
FROM supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_purchase_orders po
JOIN supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_suppliers s
    ON po.supplier_id = s.id
GROUP BY s.supplier_name
ORDER BY inventory_risk_percentage DESC;

-- 8. Compare actual and quoted lead times by supplier

SELECT
    s.supplier_name,
    COUNT(*) AS total_orders,
    ROUND(AVG(po.quoted_lead_days), 2) AS avg_quoted_lead_days,
    ROUND(AVG(po.actual_lead_days), 2) AS avg_actual_lead_days,
    ROUND(
        AVG(po.actual_lead_days - po.quoted_lead_days),
        2
    ) AS avg_days_over_quoted
FROM supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_purchase_orders po
JOIN supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_suppliers s
    ON po.supplier_id = s.id
GROUP BY s.supplier_name
ORDER BY avg_days_over_quoted DESC;

-- 9. Summarize inventory cover margin across all orders

SELECT
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN cover_margin_days < 0 THEN 1
        ELSE 0
    END) AS negative_margin_orders,
    SUM(CASE
        WHEN cover_margin_days = 0 THEN 1
        ELSE 0
    END) AS zero_margin_orders,
    SUM(CASE
        WHEN cover_margin_days > 0 THEN 1
        ELSE 0
    END) AS positive_margin_orders,
    ROUND(AVG(quoted_lead_days), 2) AS avg_quoted_lead_days,
    ROUND(AVG(actual_lead_days), 2) AS avg_actual_lead_days,
    ROUND(AVG(safety_cover_days), 2) AS avg_safety_cover_days,
    ROUND(AVG(cover_margin_days), 2) AS avg_cover_margin_days
FROM supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_purchase_orders;

-- 10. Overall summary of delivery delays and inventory risk

SELECT
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN delay_days > 0 THEN 1
        ELSE 0
    END) AS delayed_orders,
    ROUND(
        100.0 * SUM(CASE
            WHEN delay_days > 0 THEN 1
            ELSE 0
        END) / COUNT(*),
        1
    ) AS delayed_percentage,
    ROUND(AVG(delay_days), 2) AS avg_delay_days,
    SUM(CASE
        WHEN cover_margin_days < 0 THEN 1
        ELSE 0
    END) AS negative_margin_orders,
    ROUND(
        100.0 * SUM(CASE
            WHEN cover_margin_days < 0 THEN 1
            ELSE 0
        END) / COUNT(*),
        1
    ) AS inventory_risk_percentage
FROM supply_chain_dataset_purchase_orders_lead_times_and_stockouts_v1_csv_purchase_orders;

