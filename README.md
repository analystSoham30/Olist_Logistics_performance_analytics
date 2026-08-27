# Olist_Logistics_performance_analytics

The objective of this project is to analyze marketplace fulfillment performance and freight cost efficiency for Olist across 96K+ order logs in Brazil. It focuses on evaluating delivery SLA breaches, isolating fulfillment bottlenecks between seller dispatch vs. carrier transit, identifying high-risk geographic shipping lanes, and quantifying the freight cost burden relative to total order revenue.

## Dashboard preview - 

1. Fulfillment based overview:

<img width="1149" height="647" alt="Screenshot 2026-08-26 193422" src="https://github.com/user-attachments/assets/95f432b9-1a1d-41aa-83a2-45e3a91d9663" />

2. Cost based overview:
   
<img width="1168" height="650" alt="Screenshot 2026-08-26 193501" src="https://github.com/user-attachments/assets/076ca577-c5ef-466e-b2be-39526594d4b5" />


## Tech stack -
* Excel – Data source and initial data preparation
* MySQL – Data extraction, cleaning, handling missing timestamp values, and view creation (v_supply_chain_orders_clean)
* Power BI – Data modeling, DAX measure creation, and interactive two-page executive dashboard development

## Repository Architecture - 
-**/Raw database/**: Original Olist e-commerce relational dataset used for the analysis.

-**/SQL scripts/**: MySQL scripts used for data cleaning, lead time metrics computation, and relational view creation.

-**/Dashboard/**: Data visualization and dashboard creation

## Key business insights - 

1. **Fulfillment SLA & Delivery Performance:** Out of 96K total orders, 88K orders (91.86%) were delivered within promised SLAs, while 8K orders (8.14%) suffered delivery SLA breaches.

2. **Fulfillment Bottleneck Analysis:** Carrier transit time is the dominant cause of delivery delays. Delayed shipments spent an average of 25 days in carrier transit compared to 7 days for on-time deliveries. In contrast, seller dispatch lag remained stable at 5 days for late shipments versus 2 days for on-time orders.

3. **Geographic SLA Risk:** Delivery failures are concentrated in Northern and Northeastern states, led by Maranhão (MA) with a 20% breach rate, Ceará (CE) at 15%, Bahia (BA) at 14%, and Rio de Janeiro (RJ) at 14%. From an origin perspective, sellers located in MA exhibited the highest fulfillment risk with a 24% SLA breach rate.

4. **Freight Burden & Margin Impact:** Total generated revenue reached $13.16M against $2.19M in freight spend, establishing an overall Freight Burden of 16.62% with an average freight fee of $19.95 per order.

5. **Regional Freight Disparities:** Shipping costs eat heavily into revenue in long-distance buyer territories. Maranhão (MA) recorded the highest freight burden at 26.29%, followed by Pernambuco (PE) at 22.61% and Paraíba (PB) at 22.35%, significantly exceeding the baseline corridor average freight burden of 15.08%.

6. **Monthly Spend & Burden Stability:** Although total monthly shipping spend grew from under $35K in early 2017 to over $150K in 2018 due to higher order volume, the Freight Burden % stayed steady between 15% and 18.5%. This shows that shipping costs grew predictably alongside sales without eroding profit margins.


## Strategic Recommendations - 
1. **Regional Carrier Diversification:** Renegotiate carrier SLAs and partner with specialized regional 3PL providers in high-delay corridors (Rio de Janeiro - 14% breach rate and Maranhão - 20% breach rate) to directly address carrier transit time, which currently inflates from 7 days (on-time) to 25 days (late).

2. **Dynamic SLA Checkout Promise:** Adjust front-end delivery promise algorithms at checkout for high-risk buyer states (MA, CE, BA). Setting realistic ETAs based on historical carrier transit times reduces artificial SLA breach rates without placing unachievable dispatch demands on sellers.

3. **Regional Inventory Placement (3PL Hubs):** Incentivize high-volume sellers to pre-stock fast-moving SKUs in regional fulfillment centers closer to Northeastern demand centers, bypassing expensive long-haul transit that currently pushes freight burdens up to 26.29% in MA and 22.61% in PE.


