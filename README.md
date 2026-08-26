# Olist_Logistics_performance_analytics

The objective of this project is to analyze marketplace fulfillment performance and freight cost efficiency for Olist across 96K+ order logs in Brazil. It focuses on evaluating delivery SLA breaches, isolating fulfillment bottlenecks between seller dispatch vs. carrier transit, identifying high-risk geographic shipping lanes, and quantifying the freight cost burden relative to total order revenue.

Tech Stack
Excel – Data source and initial data preparation

MySQL – Data extraction, cleaning, handling missing timestamp values, calculating operational lead times, and view creation (v_supply_chain_orders_clean)

Power BI – Data modeling, DAX measure creation, and interactive two-page executive dashboard development

Repository Architecture
/raw database/: Original Olist e-commerce relational dataset used for the analysis.

/SQL scripts/: MySQL scripts used for data cleaning, lead time metrics computation, and relational view creation.

/Dashboard/: Interactive Power BI dashboard file (.pbix) and published report page visuals.

Key Business Insights
Fulfillment SLA & Delivery Performance: Out of 96K total orders, 88K orders (91.86%) were delivered within promised SLAs, while 8K orders (8.14%) suffered delivery SLA breaches.

Fulfillment Bottleneck Analysis: Carrier transit time—not seller dispatch lag—is the dominant cause of delivery delays. Delayed shipments spent an average of 25 days in carrier transit compared to 7 days for on-time deliveries. In contrast, seller dispatch lag remained stable at 5 days for late shipments versus 2 days for on-time orders.

Geographic SLA Risk: Destination delivery failures are concentrated in Northern and Northeastern states, led by Maranhão (MA) with a 20% breach rate, Ceará (CE) at 15%, Bahia (BA) at 14%, and Rio de Janeiro (RJ) at 14%. From an origin perspective, sellers located in MA exhibited the highest fulfillment risk with a 24% SLA breach rate.

Freight Burden & Margin Impact: Total generated revenue reached $13.16M against $2.19M in freight spend, establishing an overall Freight Burden of 16.62% with an average freight fee of $19.95 per order.

Regional Freight Disparities: Shipping costs eat heavily into revenue in long-distance buyer territories. Maranhão (MA) recorded the highest freight burden at 26.29%, followed by Pernambuco (PE) at 22.61% and Paraíba (PB) at 22.35%, significantly exceeding the baseline corridor average freight burden of 15.08%.


Strategic Recommendations
Regional Carrier Diversification & 3PL Integration: Renegotiate carrier SLAs and partner with specialized regional 3PL providers in high-delay corridors (Rio de Janeiro - 14% breach rate and Maranhão - 20% breach rate) to directly address carrier transit time, which currently inflates from 7 days (on-time) to 25 days (late).

Dynamic SLA Checkout Promise: Adjust front-end delivery promise algorithms at checkout for high-risk buyer states (MA, CE, BA). Setting realistic ETAs based on historical carrier transit times reduces artificial SLA breach rates without placing unachievable dispatch demands on sellers.

Regional Inventory Placement (3PL Hubs): Incentivize high-volume sellers to pre-stock fast-moving SKUs in regional fulfillment centers closer to Northeastern demand centers, bypassing expensive long-haul transit that currently pushes freight burdens up to 26.29% in MA and 22.61% in PE.

Freight Fee Restructuring & Thresholds: Implement dynamic freight caps or subsidized shipping tiers on long-haul routes where freight burden exceeds 20% of item price, helping mitigate cart abandonment while maintaining overall baseline logistics margins (16.62%).
