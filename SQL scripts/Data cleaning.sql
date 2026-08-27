Create or replace view v_supply_chain_orders as 
select 
	o.order_id,
    o.customer_id,
    oi.order_item_id,
    oi.seller_id,
    oi.product_id,
    o.order_status,
    
    -- timestamps
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    
    -- lead time metrics
    TIMESTAMPDIFF(DAY, o.order_approved_at, o.order_delivered_carrier_date) AS seller_dispatch_lag_days,
    TIMESTAMPDIFF(DAY, o.order_delivered_carrier_date, o.order_delivered_customer_date) AS carrier_transit_time_days,
    TIMESTAMPDIFF(DAY, o.order_approved_at, o.order_delivered_customer_date) AS total_fulfillment_time_days,
    TIMESTAMPDIFF(DAY, o.order_delivered_customer_date, o.order_estimated_delivery_date) AS sla_variance_days,

	-- sla status indicatior
    case
		when o.order_delivered_customer_date > o.order_estimated_delivery_date then 'Late Delivery'
        when o.order_delivered_customer_date is null then 'In-Transit/Unfulfilled'
	else 'On-Time' end as delivery_performance,
    
    -- Financials & Dimensions
    oi.price,
    oi.freight_value,
    p.product_weight_g,
    s.seller_state,
    s.seller_city,
    c.customer_state,
    c.customer_city
    
    from orders o
    inner join order_items oi on o.order_id = oi.order_id
    left join sellers s on oi.seller_id = s.seller_id
    left join customers c on o.customer_id = c.customer_id
    left join products p on oi.product_id = p.product_id;
    
    
    CREATE VIEW v_supply_chain_orders_clean AS
SELECT 
    order_id,
    customer_id,
    order_item_id,
    seller_id,
    product_id,
    order_status,
    
    -- Timestamps
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    
    -- Cleaned Lead Time Metrics
    seller_dispatch_lag_days,
    carrier_transit_time_days,
    total_fulfillment_time_days,
    sla_variance_days,
    delivery_performance,
    
    -- Dimensions & Financials (Handling Missing Dimensions)
    
    price, freight_value, coalesce(product_weight_g, 0) as product_weight_g,
    seller_state, customer_state
    
    from v_supply_chain_orders
    where order_status = 'delivered'
    and order_approved_at is not null
    and order_delivered_carrier_date is not null
    and order_delivered_customer_date is not null
    and seller_dispatch_lag_days>=0
    and carrier_transit_time_days>=0;
    
    select count(*) from v_supply_chain_orders;
    select count(*) from v_supply_chain_orders_clean;