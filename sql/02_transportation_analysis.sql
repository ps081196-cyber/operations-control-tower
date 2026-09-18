/*
=========================================================
 Operations Control Tower
 Transportation Operations Analysis
 Microsoft SQL Server
=========================================================

Purpose:
Analyze shipment volume, delivery performance,
carrier performance, exceptions and SLA breaches.

Dataset: Synthetic portfolio data
=========================================================
*/

USE amazon_operations;
GO


/* =====================================================
   1. OVERALL TRANSPORTATION KPIs
   ===================================================== */

SELECT
    COUNT(*) AS total_shipments,

    SUM(
        CASE
            WHEN actual_delivery_date <= promised_delivery_date
            THEN 1 ELSE 0
        END
    ) AS on_time_shipments,

    SUM(
        CASE
            WHEN actual_delivery_date > promised_delivery_date
            THEN 1 ELSE 0
        END
    ) AS delayed_shipments,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN actual_delivery_date <= promised_delivery_date
                THEN 1 ELSE 0
            END
        ) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS on_time_delivery_percentage

FROM shipments;
GO


/* =====================================================
   2. CARRIER PERFORMANCE
   ===================================================== */

SELECT
    carrier,

    COUNT(*) AS total_shipments,

    SUM(
        CASE
            WHEN actual_delivery_date <= promised_delivery_date
            THEN 1 ELSE 0
        END
    ) AS on_time_shipments,

    SUM(
        CASE
            WHEN actual_delivery_date > promised_delivery_date
            THEN 1 ELSE 0
        END
    ) AS delayed_shipments,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN actual_delivery_date <= promised_delivery_date
                THEN 1 ELSE 0
            END
        ) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS on_time_percentage

FROM shipments
GROUP BY carrier
ORDER BY on_time_percentage DESC;
GO


/* =====================================================
   3. DELIVERY EXCEPTION / ROOT CAUSE ANALYSIS
   ===================================================== */

SELECT
    exception_type,
    COUNT(*) AS total_shipments,

    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS percentage

FROM shipments
GROUP BY exception_type
ORDER BY total_shipments DESC;
GO


/* =====================================================
   4. DELAY ANALYSIS BY EXCEPTION
   ===================================================== */

SELECT
    exception_type,

    COUNT(*) AS delayed_shipments,

    CAST(
        AVG(
            DATEDIFF(
                DAY,
                promised_delivery_date,
                actual_delivery_date
            ) * 1.0
        )
        AS DECIMAL(5,2)
    ) AS avg_delay_days

FROM shipments

WHERE actual_delivery_date > promised_delivery_date

GROUP BY exception_type
ORDER BY delayed_shipments DESC;
GO


/* =====================================================
   5. ROUTE PERFORMANCE
   ===================================================== */

SELECT
    origin_station,
    destination_station,

    COUNT(*) AS total_shipments,

    SUM(
        CASE
            WHEN actual_delivery_date > promised_delivery_date
            THEN 1 ELSE 0
        END
    ) AS delayed_shipments,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN actual_delivery_date <= promised_delivery_date
                THEN 1 ELSE 0
            END
        ) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS on_time_percentage

FROM shipments

GROUP BY
    origin_station,
    destination_station

ORDER BY on_time_percentage ASC;
GO


/* =====================================================
   6. SHIPMENT VOLUME BY DATE
   ===================================================== */

SELECT
    shipment_date,
    COUNT(*) AS total_shipments

FROM shipments

GROUP BY shipment_date
ORDER BY shipment_date;
GO
