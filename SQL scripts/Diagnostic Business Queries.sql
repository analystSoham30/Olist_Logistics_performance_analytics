-- Determine whether late deliveries are primarily caused by sellers taking too long to dispatch orders or carriers taking too long in transit
WITH unique_orders AS (
    SELECT DISTINCT
        order_id,
        delivery_performance,
        seller_dispatch_lag_days,
        carrier_transit_time_days
    FROM v_supply_chain_orders_clean
)

SELECT 
    delivery_performance,
    ROUND(AVG(seller_dispatch_lag_days), 2) AS avg_seller_dispatch_lag_days,
    ROUND(AVG(carrier_transit_time_days), 2) AS avg_carrier_transit_time_days
FROM unique_orders
GROUP BY delivery_performance;

-- Find customer states with the highest SLA breach rate to highlight last-mile coverage issues.

with cte as ( 
	select customer_state as state,
	count(distinct case when delivery_performance = "Late delivery" then order_id end) as late_delivery_count,
    count(distinct order_id) as Total_orders
	from v_supply_chain_orders_clean
    group by customer_state
    having count(distinct order_id)>=500
)

select *, round((late_delivery_count/Total_orders*100),2) as late_delivery_percentage
from cte
order by late_delivery_percentage desc;

-- Determine if heavier shipments suffer from higher freight costs or longer carrier transit delays.

SELECT 
    CASE 
        WHEN product_weight_g < 1000 THEN '1. < 1kg'
        WHEN product_weight_g BETWEEN 1000 AND 4999 THEN '2. 1kg - 5kg'
        WHEN product_weight_g BETWEEN 5000 AND 9999 THEN '3. 5kg - 10kg'
        ELSE '4. 10kg+'
    END AS weight_band,
    COUNT(*) AS total_items,
    ROUND(AVG(freight_value), 2) AS avg_freight,
    ROUND(AVG(carrier_transit_time_days), 2) AS avg_transit_days
FROM v_supply_chain_orders_clean
GROUP BY weight_band
ORDER BY weight_band;
    
