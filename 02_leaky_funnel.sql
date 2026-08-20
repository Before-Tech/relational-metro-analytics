SELECT 
    COUNT(DISTINCT order_id) AS total_orders_placed,
    COUNT(DISTINCT CASE WHEN approved_timestamp IS NOT NULL THEN order_id END) AS orders_approved,
    COUNT(DISTINCT CASE WHEN shipped_timestamp IS NOT NULL THEN order_id END) AS orders_shipped,
    COUNT(DISTINCT CASE WHEN delivered_timestamp IS NOT NULL THEN order_id END) AS orders_delivered,
    
    -- Conversion / Funnel Completion Rates (%)
    ROUND(SAFE_DIVIDE(COUNT(DISTINCT CASE WHEN approved_timestamp IS NOT NULL THEN order_id END), COUNT(DISTINCT order_id)) * 100, 2) AS approval_rate_pct,
    ROUND(SAFE_DIVIDE(COUNT(DISTINCT CASE WHEN shipped_timestamp IS NOT NULL THEN order_id END), COUNT(DISTINCT approved_timestamp)) * 100, 2) AS fulfillment_rate_pct,
    ROUND(SAFE_DIVIDE(COUNT(DISTINCT CASE WHEN delivered_timestamp IS NOT NULL THEN order_id END), COUNT(DISTINCT shipped_timestamp)) * 100, 2) AS delivery_rate_pct,
    
    -- Operational Latency (Average Days per Stage)
    ROUND(AVG(TIMESTAMP_DIFF(approved_timestamp, purchase_timestamp, HOUR) / 24.0), 2) AS avg_hours_to_approve_days,
    ROUND(AVG(TIMESTAMP_DIFF(shipped_timestamp, approved_timestamp, HOUR) / 24.0), 2) AS avg_approval_to_carrier_days,
    ROUND(AVG(TIMESTAMP_DIFF(delivered_timestamp, shipped_timestamp, HOUR) / 24.0), 2) AS avg_carrier_to_delivery_days,
    ROUND(AVG(TIMESTAMP_DIFF(delivered_timestamp, purchase_timestamp, HOUR) / 24.0), 2) AS avg_total_fulfillment_days,
    
    -- SLA Compliance Rate
    ROUND(AVG(is_delivered_on_time) * 100, 2) AS sla_met_pct
FROM `relational-metro-analytics.raw_ecommerce.stg_orders`;
