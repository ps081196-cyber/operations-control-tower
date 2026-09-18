/*
=========================================================
 Operations Control Tower
 Power BI Analytics Views
 Microsoft SQL Server

 These views provide reporting-ready datasets
 for the Power BI dashboards.

 Dataset: Synthetic portfolio data
=========================================================
*/

USE amazon_operations;
GO


/* =====================================================
   1. TRANSPORTATION CONTROL TOWER VIEW
   ===================================================== */

CREATE OR ALTER VIEW vw_transportation_control_tower
AS

SELECT
    shipment_id,
    shipment_date,
    origin_station,
    destination_station,
    carrier,
    promised_delivery_date,
    actual_delivery_date,
    shipment_status,
    exception_type,
    distance_km,

    -- Number of days late
    CASE
        WHEN actual_delivery_date > promised_delivery_date
        THEN DATEDIFF(
            DAY,
            promised_delivery_date,
            actual_delivery_date
        )
        ELSE 0
    END AS delay_days,

    -- Delivery performance
    CASE
        WHEN actual_delivery_date <= promised_delivery_date
        THEN 'On Time'
        ELSE 'Delayed'
    END AS delivery_performance,

    -- SLA breach indicator
    CASE
        WHEN actual_delivery_date > promised_delivery_date
        THEN 'Yes'
        ELSE 'No'
    END AS sla_breach,

    -- Operational priority
    CASE
        WHEN DATEDIFF(
            DAY,
            promised_delivery_date,
            actual_delivery_date
        ) >= 3 THEN 'High'

        WHEN DATEDIFF(
            DAY,
            promised_delivery_date,
            actual_delivery_date
        ) = 2 THEN 'Medium'

        WHEN DATEDIFF(
            DAY,
            promised_delivery_date,
            actual_delivery_date
        ) = 1 THEN 'Low'

        ELSE 'No Breach'
    END AS priority

FROM shipments;
GO


/* =====================================================
   2. INVESTIGATION & RISK OPERATIONS VIEW
   ===================================================== */

CREATE OR ALTER VIEW vw_investigation_risk_operations
AS

SELECT
    case_id,
    case_date,
    case_type,
    risk_level,
    investigation_status,
    resolution,
    sla_hours,
    resolution_hours,
    investigator_team,
    escalation_status,
    transaction_value,

    -- SLA status
    CASE
        WHEN resolution_hours <= sla_hours
        THEN 'Within SLA'
        ELSE 'SLA Breached'
    END AS sla_status,

    -- Hours beyond SLA
    CASE
        WHEN resolution_hours > sla_hours
        THEN resolution_hours - sla_hours
        ELSE 0
    END AS sla_breach_hours,

    -- Operational case priority
    CASE
        WHEN risk_level = 'High'
             AND escalation_status = 'Escalated'
        THEN 'Critical'

        WHEN risk_level = 'High'
        THEN 'High'

        WHEN risk_level = 'Medium'
        THEN 'Medium'

        ELSE 'Low'
    END AS case_priority,

    -- Resolution performance
    CASE
        WHEN resolution_hours <= sla_hours
        THEN 'On Target'
        ELSE 'Over Target'
    END AS resolution_performance,

    -- Transaction value segmentation
    CASE
        WHEN transaction_value >= 30000
        THEN 'High Value'

        WHEN transaction_value >= 10000
        THEN 'Medium Value'

        ELSE 'Low Value'
    END AS value_risk_category

FROM investigation_cases;
GO
