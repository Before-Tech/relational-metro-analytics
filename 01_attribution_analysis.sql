WITH order_payments AS (
    SELECT 
        order_id,
        payment_type,
        SUM(payment_value) AS total_payment_value
    FROM `relational-metro-analytics.raw_ecommerce.stg_payments`
    GROUP BY 1, 2
),
order_categories AS (
    SELECT DISTINCT
        i.order_id,
        COALESCE(p.product_category_name, 'Uncategorized') AS product_category
    FROM `relational-metro-analytics.raw_ecommerce.order_items` i
    LEFT JOIN `relational-metro-analytics.raw_ecommerce.products` p
        ON i.product_id = p.product_id
)
SELECT 
    oc.product_category,
    op.payment_type,
    COUNT(DISTINCT op.order_id) AS total_transactions,
    ROUND(SUM(op.total_payment_value), 2) AS total_revenue,
    ROUND(SAFE_DIVIDE(SUM(op.total_payment_value), COUNT(DISTINCT op.order_id)), 2) AS average_order_value
FROM order_payments op
INNER JOIN `relational-metro-analytics.raw_ecommerce.stg_orders` o
    ON op.order_id = o.order_id
LEFT JOIN order_categories oc
    ON op.order_id = oc.order_id
GROUP BY 1, 2
ORDER BY total_revenue DESC;
