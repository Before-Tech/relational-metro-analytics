WITH customer_rfm AS (
    SELECT 
        c.customer_unique_id,
        MAX(o.purchase_timestamp) AS last_purchase_timestamp,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(p.payment_value) AS monetary
    FROM `relational-metro-analytics.raw_ecommerce.stg_customers` c
    INNER JOIN `relational-metro-analytics.raw_ecommerce.stg_orders` o
        ON c.customer_id = o.customer_id
    INNER JOIN `relational-metro-analytics.raw_ecommerce.stg_payments` p
        ON o.order_id = p.order_id
    GROUP BY c.customer_unique_id
),
reference_date AS (
    SELECT MAX(purchase_timestamp) AS max_date FROM `relational-metro-analytics.raw_ecommerce.stg_orders`
),
rfm_scores AS (
    SELECT 
        r.customer_unique_id,
        TIMESTAMP_DIFF((SELECT max_date FROM reference_date), r.last_purchase_timestamp, DAY) AS recency_days,
        r.frequency,
        ROUND(r.monetary, 2) AS monetary_value,
        NTILE(4) OVER (ORDER BY TIMESTAMP_DIFF((SELECT max_date FROM reference_date), r.last_purchase_timestamp, DAY) DESC) AS r_score,
        NTILE(4) OVER (ORDER BY r.frequency ASC) AS f_score,
        NTILE(4) OVER (ORDER BY r.monetary ASC) AS m_score
    FROM customer_rfm r
)
SELECT 
    customer_unique_id,
    recency_days,
    frequency,
    monetary_value,
    CONCAT(CAST(r_score AS STRING), CAST(f_score AS STRING), CAST(m_score AS STRING)) AS rfm_combined,
    CASE 
        WHEN r_score = 4 AND f_score >= 3 AND m_score >= 3 THEN 'Loyal Champions'
        WHEN r_score >= 3 AND m_score >= 3 THEN 'High-Value Recent'
        WHEN r_score <= 2 AND f_score >= 2 THEN 'At Risk / Drifting'
        WHEN r_score = 1 THEN 'Churned Accounts'
        ELSE 'Casual Shoppers'
    END AS customer_segment
FROM rfm_scores
ORDER BY monetary_value DESC;
